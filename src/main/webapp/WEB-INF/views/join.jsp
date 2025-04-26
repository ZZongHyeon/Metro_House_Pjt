<%@ page language="java" contentType="text/html; charset=UTF-8"
 	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메트로하우스 - 회원가입</title>
<link rel="stylesheet" type="text/css" href="/resources/css/joinview.css">
<script src="/resources/js/join.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script type="text/javascript">
function fn_submit() {
    const form = document.getElementById("joinForm"); 
    // 유효성 검사 실행
    if (!form.checkValidity()) {
        form.reportValidity();  // 브라우저 기본 경고창 띄움
        return;  // 중단
    }
    var formData = $("#joinForm").serialize();
    $.ajax({
        type: "post",
        data: formData,
        url: "join",
        success: function(data) {
            alert("회원가입이 정상적으로 처리되었습니다.");
            location.href = "loginView";
        },
        error: function(xhr) {
            if (xhr.status === 409) {
                alert("이미 존재하는 아이디입니다. 다른 아이디를 사용해주세요.");
            } else {
                alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            }
        }
    });
}
</script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="container">
		<h2>메트로하우스 회원가입</h2>
		
		<div class="form-intro">
		    <p>메트로하우스 지하철역 주변 아파트 시세 서비스 이용을 위한 회원가입 페이지입니다.<br>아래 정보를 입력하여 회원가입을 완료해주세요.</p>
		</div>
		
		<div class="progress-container">
		    <div class="progress-bar">
		        <div class="step">1<span class="step-label">정보 입력</span></div>
		        <div class="step">2<span class="step-label">가입 완료</span></div>
		    </div>
		</div>
		
		<form id="joinForm">
			<div class="form-group">
				<label>아이디 <span class="required-mark">*</span></label>
				<input type="text" name="userId"
				required
				placeholder="영문, 숫자로 4~12자 입력"
				pattern="^[a-zA-Z0-9]{4,12}$"
				oninvalid="this.setCustomValidity('아이디는 영문, 숫자로 4~12자로 입력해주세요.')"
				oninput="setCustomValidity('')">
				<span class="input-hint">영문, 숫자를 조합하여 4~12자로 입력해주세요.</span>
				<span class="error-message">아이디는 영문, 숫자로 4~12자로 입력해주세요.</span>
			</div>
			
			<div class="form-group">
				<label>이름 <span class="required-mark">*</span></label>
				<input type="text" name="userName"
				required
				placeholder="한글 2~4자 입력"
				pattern="^[가-힣]{2,4}$"
				oninvalid="this.setCustomValidity('이름은 한글 2~4자로 입력해주세요.')"
				oninput="setCustomValidity('')">
				<span class="input-hint">한글 2~4자로 입력해주세요.</span>
				<span class="error-message">이름은 한글 2~4자로 입력해주세요.</span>
			</div>
			
			<div class="form-group">
				<label>비밀번호 <span class="required-mark">*</span></label>
				<input type="password" name="userPw" id="userPw"
				required
				placeholder="영문, 숫자, 특수문자 포함 8~16자"
				pattern="^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*]).{6,16}$"
				oninvalid="this.setCustomValidity('비밀번호는 영문, 숫자, 특수문자를 포함하여 6~16자로 입력해주세요.')"
				oninput="checkPasswordStrength(this); setCustomValidity('')">
				<div class="password-strength">
				    <div class="password-strength-bar" id="passwordStrengthBar"></div>
				</div>
				<span class="input-hint">영문, 숫자, 특수문자를 포함하여 6~16자로 입력해주세요.</span>
				<span class="error-message">비밀번호는 영문, 숫자, 특수문자를 포함하여 6~16자로 입력해주세요.</span>
			</div>
			
			<div class="form-group">
				<label>비밀번호 확인 <span class="required-mark">*</span></label>
				<input type="password" name="pwdConfirm" id="pwdConfirm"
				required
				placeholder="비밀번호를 다시 입력"
				oninput="checkPasswordMatch(this)">
				<span class="input-hint">비밀번호를 한번 더 입력해주세요.</span>
				<span class="error-message" id="pwMatchError">비밀번호가 일치하지 않습니다.</span>
			</div>
			
			<div class="form-group">
				<label>이메일 <span class="required-mark">*</span></label>
				<input type="email" name="userEmail"
				required
				placeholder="example@email.com"
				pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
				oninvalid="this.setCustomValidity('올바른 이메일 주소 형식으로 입력해주세요.')"
				oninput="setCustomValidity('')">
				<span class="input-hint">이메일 주소를 입력해주세요.</span>
				<span class="error-message">올바른 이메일 주소 형식으로 입력해주세요.</span>
			</div>
			
			<div class="form-group">
				<label>전화번호 <span class="required-mark">*</span></label>
				<input type="tel" name="userTel"
				required
				placeholder="010-0000-0000"
				pattern="^010-\d{4}-\d{4}$"
				oninvalid="this.setCustomValidity('올바른 전화번호 형식(010-0000-0000)으로 입력해주세요.')"
				oninput="setCustomValidity('')">
				<span class="input-hint">010-0000-0000 형식으로 입력해주세요.</span>
				<span class="error-message">올바른 전화번호 형식(010-0000-0000)으로 입력해주세요.</span>
			</div>
			
			<div class="form-group">
				<label>생년월일 <span class="required-mark">*</span></label>
				
				<input type="date" name="userBirth"
				required
				oninvalid="this.setCustomValidity('생년월일을 선택해주세요.')"
				oninput="setCustomValidity('')">
				
				<span class="input-hint">생년월일을 선택해주세요.</span>
				<span class="error-message">생년월일을 선택해주세요.</span>
			</div>
			
			<div class="form-group full-width">
				<label>주소 <span class="required-mark">*</span></label>
				
				<input type="text" name="userZipCode" id="zipCode" required
				    placeholder="우편번호 입력"
				    oninvalid="this.setCustomValidity('우편번호를 선택해주세요.')"
					oninput="setCustomValidity('')">

			    	
			    <span class="input-hint">우편번호를 입력해주세요.</span>
				<span class="error-message">우편번호를 입력해주세요.</span>
				<div class="address-search">
				    <input type="text" name="userAddress" id="userAddress" required
				    placeholder="도로명 또는 지번 주소 입력"
				    oninvalid="this.setCustomValidity('주소를 입력해주세요.')"
				    oninput="setCustomValidity('')">
				    <button type="button" onclick="searchAddress()">주소 검색</button>
				</div>
				<span class="input-hint">도로명 또는 지번 주소를 입력해주세요.</span>
				<span class="error-message">주소를 입력해주세요.</span>
			</div>
			
			<div class="form-group full-width">
				<label>상세 주소</label>
				<input type="text" name="userDetailAddress" placeholder="상세 주소 입력 (선택사항)">
				<span class="input-hint">아파트, ���/호수 등 상세 주소를 입력해주세요.</span>
			</div>
			
			<div class="terms-container">
			    <div class="terms-title">이용약관 동의 <span class="required-mark">*</span></div>
			    <div class="terms-scroll">
			        제1조 (목적)<br>
			        이 약관은 메트로하우스(이하 "서비스")를 이용함에 있어 서비스와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.<br><br>
			        
			        제2조 (정의)<br>
			        1. "서비스"란 지하철역 주변 아파트 시세 정보 제공을 위해 제공하는 서비스를 말합니다.<br>
			        2. "이용자"란 서비스에 접속하여 이 약관에 따라 서비스가 제공하는 정보를 이용하는 회원을 말합니다.<br><br>
			        
			        제3조 (약관의 효력 및 변경)<br>
			        1. 이 약관은 서비스 웹사이트에 게시하여 공시합니다.<br>
			        2. 서비스는 필요한 경우 약관을 변경할 수 있으며, 변경된 약관은 공지사항을 통해 공시합니다.<br><br>
			        
			        제4조 (서비스의 제공 및 변경)<br>
			        1. 서비스는 다음과 같은 서비스를 제공합니다.<br>
			           - 지하철역 주변 아파트 시세 정보 제공<br>
			           - 아파트 시세 비교 서비스<br>
			           - 관심 아파트 등록 및 관리 서비스<br>
			        2. 서비스는 필요한 경우 서비스의 내용을 변경할 수 있습니다.<br>
			    </div>
			    <div class="terms-checkbox">
			        <input type="checkbox" id="termsAgree" required>
			        <label for="termsAgree">이용약관에 동의합니다. (필수)</label>
			    </div>
			</div>
			
			<div class="terms-container">
			    <div class="terms-title">개인정보 수집 및 이용 동의 <span class="required-mark">*</span></div>
			    <div class="terms-scroll">
			        1. 수집하는 개인정보 항목<br>
			        - 필수항목: 아이디, 비밀번호, 이름, 이메일, 전화번호, 생년월일, 주소<br>
			        - 선택항목: 상세 주소<br><br>
			        
			        2. 개인정보의 수집 및 이용목적<br>
			        - 회원 관리: 회원제 서비스 이용에 따른 본인확인, 개인식별, 불량회원의 부정이용 방지와 비인가 사용 방지, 가입의사 확인, 연령확인, 불만처리 등 민원처리, 고지사항 전달<br>
			        - 서비스 제공: 아파트 시세 정보 제공, 관심 아파트 관리 등<br><br>
			        
			        3. 개인정보의 보유 및 이용기간<br>
			        - 회원 탈퇴 시까지 (단, 관계법령에 따라 필요한 경우 일정기간 보존할 수 있음)<br><br>
			        
			        4. 동의 거부권 및 거부 시 불이익<br>
			        - 귀하는 개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있습니다. 다만, 동의를 거부할 경우 회원가입이 제한됩니다.<br>
			    </div>
			    <div class="terms-checkbox">
			        <input type="checkbox" id="privacyAgree" required>
			        <label for="privacyAgree">개인정보 수집 및 이용에 동의합니다. (필수)</label>
			    </div>
			</div>
			
			<div class="button-group">
				<input type="button" value="회원가입" class="btn btn-primary" onclick="fn_submit()">
				<input type="button" value="뒤로가기" onclick="location='/loginView'" class="btn btn-secondary">
			</div>
		</form>
	</div>
	
  	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
	function searchAddress() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 우편번호와 도로명 주소 설정
	            const zipCode =  document.getElementById("zipCode")
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
  		    switch(strength) {
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
  		document.getElementById("joinForm").addEventListener("submit", function(event) {
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
 	</script> 
</body>
</html>