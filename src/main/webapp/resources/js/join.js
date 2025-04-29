$(document).ready(function () {
    // 버튼 클릭 제한 변수
    let isButtonDisabled = false;

    // 이메일 인증 상태 관리 변수
    let emailVerificationSent = false; // 인증번호 발송 여부
    let emailVerified = false; // 이메일 인증 완료 여부
    let serverCode = ""; // 서버에서 받은 인증번호

    // 인증 상태 메시지 표시 함수
    function updateVerificationStatus(isValid) {
        const message = isValid ? "인증번호 확인 완료" : "인증번호가 잘못되었습니다";
        const color = isValid ? "#0D6EFD" : "#FA3E3E";

        $("#memailconfirmTxt").html(`<span id='emconfirmchk'>${message}</span>`);
        $("#emconfirmchk").css({
            "color": color,
            "font-weight": "bold",
            "font-size": "12px"
        });

        // 인증 상태 업데이트
        emailVerified = isValid;

        // 인증 완료 시 입력 필드와 버튼 비활성화
        if (isValid) {
            $("#verificationCode").prop("disabled", true);
            $("#userEmail").prop("readonly", true);
            // $("#userEmail").prop("disabled", true);
            $("#checkEmail").prop("disabled", true);
            $("#verifyEmailBtn").prop("disabled", true).css("opacity", "0.5");
            $("#checkEmail").prop("disabled", true).css("opacity", "0.5");
        }
    }


    // 인증번호 확인 함수
    function verifyCode(inputCode, showAlert = false) {
        if (!inputCode) {
            if (showAlert) alert("인증번호를 입력해주세요.");
            return false;
        }

        const isValid = serverCode === inputCode;

        updateVerificationStatus(isValid);

        if (showAlert) {
            if (isValid) {
                alert("이메일 인증이 완료되었습니다.");
            } else {
                alert("인증번호가 일치하지 않습니다. 다시 확인해주세요.");
            }
        }

        return isValid;
    }

    // 이메일 인증 확인 함수
    function checkEmailVerification() {
        if (!emailVerified || !emailVerificationSent) {
            alert("이메일 인증을 완료해주세요.");
            return false;
        }

        return true;
    }

    // 인증번호 발송 버튼 클릭 이벤트
    $("#checkEmail").click(function () {
        if (isButtonDisabled) {
            return;
        }
        const email = $("#userEmail").val();

        if (!email) {
            alert("이메일을 입력해주세요.");
            return;
        }

        // 이메일 형식 검증
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailPattern.test(email)) {
            alert("올바른 이메일 형식이 아닙니다.");
            return;
        }
        // 버튼 비활성화 및 시각적 피드백
        isButtonDisabled = true;
        const $button = $(this);
        const originalText = $button.text();
        let countdown = 3;

        $button.prop("disabled", true)
            .addClass("disabled")
            .css("opacity", "0.7")
            // .text("${countdown}초 후 재시도");

        // 카운트다운 타이머 시작
        const countdownInterval = setInterval(function () {
            countdown--;
            // $button.text("${countdown}초 후 재시도");

            if (countdown <= 0) {
                clearInterval(countdownInterval);
                $button.prop("disabled", false)
                    .removeClass("disabled")
                    .css("opacity", "1")
                    .text(originalText);
                isButtonDisabled = false;
            }
        }, 1000);

        // 서버에 이메일 인증 요청
        $.ajax({
            type: "POST",
            url: "/mailConfirm",
            dataType: "text",
            data: {
                "email": email
            },
            success: function (data) {
                // 응답이 HTML인지 확인
                // if (data.includes("<html>") || data.includes("<!DOCTYPE html>")) {
                // 	console.error("HTML 응답이 반환됨. 올바른 엔드포인트가 아닙니다.");
                // 	alert("서버 오류가 발생했습니다. 관리자에게 문의하세요.");
                // 	return;
                // }

                alert("해당 이메일로 인증번호 발송이 완료되었습니다.");
                console.log("받은 인증코드: " + data);

                // 인증번호 입력 필드 표시
                $("#verificationCodeGroup").show();
                emailVerificationSent = true;

                // 서버에서 받은 인증번호 저장
                serverCode = data.trim();
            },
            error: function (xhr, status, error) {
                alert("이메일 발송 중 오류가 발생했습니다. 다시 시도해주세요.");
                console.error("이메일 발송 오류:", xhr.status, error);
                console.log("응답 텍스트:", xhr.responseText);
            }
        });
    });

    // 인증번호 입력 필드 키업 이벤트
    // $("#verificationCode").on("keyup", function () {
    // 	verifyCode($(this).val());
    // });

    // 인증 확인 버튼 클릭 이벤트
    $("#verifyEmailBtn").click(function () {
        verifyCode($("#verificationCode").val(), true);
    });

    // 폼 제출 전 유효성 검사에 이메일 인증 확인 추가
    $("#joinForm").on("submit", function (event) {
        if (!checkEmailVerification()) {
            event.preventDefault();
            return false;
        }
        return true;
    });

    // fn_submit 함수에도 이메일 인증 확인 추가
    window.fn_submit = function () {
        if (!checkEmailVerification()) {
            return;
        }

        const form = document.getElementById("joinForm");

        // 유효성 검사 실행
        if (!form.checkValidity()) {
            form.reportValidity();
            return;
        }

        var formData = $("#joinForm").serialize();
        $.ajax({
            type: "post",
            data: formData,
            url: "joinProc",
            success: function (data) {
                alert("회원가입이 정상적으로 처리되었습니다.");
                location.href = "loginForm";
            },
            error: function (xhr) {
                if (xhr.status === 409) {
                    alert("이미 존재하는 아이디입니다. 다른 아이디를 사용해주세요.");
                } else {
                    alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
                }
            }
        });
    };
});

function searchAddress() {
    new daum.Postcode({
        oncomplete: function (data) {
            // 우편번호와 도로명 주소 설정
            const zipCode = document.getElementById("zipCode")
            const userAddress = document.getElementById("userAddress")

            zipCode.value = data.zonecode;
            userAddress.value = data.roadAddress;


            zipCode.readOnly = true;
            userAddress.readOnly = true;
        }
    }).open();
}
function checkPasswordMatch(input) {
    var password = document.getElementById("userPw").value;
    var confirmError = document.getElementById("pwMatchError");

    if (input.value !== password) {
        input.setCustomValidity("비밀번호가 일치하지 않습니다.");
        confirmError.style.display = "block";
    } else {
        input.setCustomValidity("");
        confirmError.style.display = "none";
    }
}

function checkPasswordStrength(input) {
    var password = input.value;
    var strengthBar = document.getElementById("passwordStrengthBar");
    var strength = 0;

    if (password.length >= 6) strength += 1;
    if (password.length >= 10) strength += 1;
    if (/[A-Z]/.test(password)) strength += 1;
    if (/[0-9]/.test(password)) strength += 1;
    if (/[^A-Za-z0-9]/.test(password)) strength += 1;

    // Update the strength bar
    switch (strength) {
        case 0:
            strengthBar.style.width = "0%";
            strengthBar.style.backgroundColor = "#e11d48";
            break;
        case 1:
            strengthBar.style.width = "20%";
            strengthBar.style.backgroundColor = "#e11d48";
            break;
        case 2:
            strengthBar.style.width = "40%";
            strengthBar.style.backgroundColor = "#f59e0b";
            break;
        case 3:
            strengthBar.style.width = "60%";
            strengthBar.style.backgroundColor = "#f59e0b";
            break;
        case 4:
            strengthBar.style.width = "80%";
            strengthBar.style.backgroundColor = "#10b981";
            break;
        case 5:
            strengthBar.style.width = "100%";
            strengthBar.style.backgroundColor = "#10b981";
            break;
    }
}



// 폼 제출 전 유효성 검사
document.getElementById("joinForm").addEventListener("submit", function (event) {
    var password = document.getElementById("userPw").value;
    var confirmPassword = document.getElementById("pwdConfirm").value;
    var termsAgree = document.getElementById("termsAgree").checked;
    var privacyAgree = document.getElementById("privacyAgree").checked;

    if (password !== confirmPassword) {
        event.preventDefault();
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }

    if (!termsAgree || !privacyAgree) {
        event.preventDefault();
        alert("이용약관과 개인정보 수집 및 이용에 동의해주세요.");
        return false;
    }

    return true;
});