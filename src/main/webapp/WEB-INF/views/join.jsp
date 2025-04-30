<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메트로하우스 - 회원가입</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --primary: #51bdbd;
            --primary-dark: #3e9a9a;
            --primary-light: #a0dbdb;
            --secondary: #5a6878;
            --accent: #10b981;
            --accent2: #f97316;
            --accent3: #06b6d4;
            --accent4: #8b5cf6;
            --success: #22c55e;
            --danger: #ef4444;
            --warning: #f59e0b;
            --info: #0ea5e9;
            --light: #f8fafc;
            --dark: #1e293b;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --border-radius: 12px;
            --box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            --box-shadow-hover: 0 10px 15px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
            --progress-width: 0%;
        }

        * {
            box-sizing: border-box;
            font-family: "Noto Sans KR", sans-serif;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: var(--light);
            color: var(--dark);
        }

        .container {
            max-width: 700px;
            margin: 30px auto 60px;
            padding: 30px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        h2 {
            text-align: center;
            color: var(--primary);
            margin-bottom: 30px;
            font-size: 28px;
        }

        .form-intro {
            text-align: center;
            margin-bottom: 30px;
            color: var(--gray-500);
        }

        form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        label {
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--secondary);
            display: flex;
            align-items: center;
        }

        .required-mark {
            color: var(--danger);
            margin-left: 4px;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="tel"],
        input[type="date"] {
            padding: 12px 15px;
            border: 1px solid var(--gray-200);
            border-radius: var(--border-radius);
            font-size: 16px;
            transition: var(--transition);
        }

        input:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 2px rgba(81, 189, 189, 0.2);
        }

        input:invalid {
            border-color: var(--danger);
        }

        .input-hint {
            font-size: 12px;
            color: var(--gray-500);
            margin-top: 5px;
        }

        .error-message {
            color: var(--danger);
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }

        input:invalid + .error-message {
            display: block;
        }

        .button-group {
            grid-column: span 2;
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .btn {
            flex: 1;
            padding: 12px 15px;
            border: none;
            border-radius: var(--border-radius);
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .btn::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .btn-secondary {
            background-color: var(--gray-200);
            color: var(--secondary);
        }

        .btn-secondary:hover {
            background-color: var(--gray-300);
        }

        .progress-container {
            width: 100%;
            margin-bottom: 30px;
            grid-column: span 2;
        }

        .progress-bar {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin-bottom: 30px;
        }

        .progress-bar::before {
            content: "";
            position: absolute;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
            height: 4px;
            width: 100%;
            background-color: var(--gray-200);
            z-index: 1;
        }

        .progress-bar::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
            height: 4px;
            width: var(--progress-width);
            background-color: var(--primary);
            z-index: 2;
            transition: width 0.5s ease;
        }

        .step {
            width: 30px;
            height: 30px;
            background-color: var(--gray-200);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--gray-500);
            font-weight: bold;
            position: relative;
            z-index: 3;
            transition: all 0.3s ease;
        }

        .step.active {
            background-color: var(--primary);
            color: white;
        }

        .step.completed {
            background-color: var(--success);
            color: white;
        }

		.step.completed::before {
		    content: "";
		    position: absolute;
		    font-size: 16px;
		}
		.step.completed span {
		    display: none;
		}
        .step-label {
            position: absolute;
            top: 35px;
            left: 50%;
            transform: translateX(-50%);
            white-space: nowrap;
            font-size: 12px;
            color: var(--gray-500);
        }

        .step.active .step-label {
            color: var(--primary);
            font-weight: 500;
        }

        .step.completed .step-label {
            color: var(--success);
            font-weight: 500;
        }

        .terms-container {
            grid-column: span 2;
            margin-top: 20px;
            padding: 15px;
            background-color: var(--gray-100);
            border-radius: var(--border-radius);
            border: 1px solid var(--gray-200);
        }

        .terms-title {
            font-weight: 500;
            margin-bottom: 10px;
        }

        .terms-scroll {
            height: 100px;
            overflow-y: auto;
            padding: 10px;
            background-color: white;
            border: 1px solid var(--gray-200);
            border-radius: var(--border-radius);
            font-size: 14px;
            margin-bottom: 10px;
        }

        .terms-checkbox {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .address-search {
            display: flex;
            gap: 10px;
        }

        .address-search input {
            flex: 1;
        }

        .address-search button {
            padding: 0 15px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: var(--transition);
        }

        .address-search button:hover {
            background-color: var(--primary-dark);
        }

        .password-strength {
            height: 5px;
            background-color: var(--gray-200);
            border-radius: 5px;
            margin-top: 8px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            border-radius: 5px;
            transition: width 0.3s, background-color 0.3s;
        }

        .form-row {
            display: flex;
            gap: 10px;
            grid-column: span 2;
        }

        .form-row .form-group {
            flex: 1;
        }

        .email-group,
        .phone-group {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .email-group input,
        .phone-group input {
            flex: 1;
        }

        .verify-button {
            padding: 12px 15px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: var(--transition);
            white-space: nowrap;
            height: 45px;
            width: 120px;
            text-align: center;
            flex-shrink: 0;
        }

        .verify-button:hover {
            background-color: var(--primary-dark);
        }

        #verificationCodeGroup {
            display: none;
            margin-top: 10px;
        }

        /* 이메일 입력란과 인증번호 입력란의 너비를 동일하게 설정 */
        .email-group,
        #verificationCodeGroup {
            display: flex;
            gap: 10px;
            align-items: center;
            width: 100%;
        }

        .email-group input,
        #verificationCodeGroup input {
            width: calc(100% - 130px); /* 버튼 너비(120px) + 간격(10px)을 뺀 너비 */
            flex-shrink: 1;
        }

        /* 단계별 폼 스타일 */
        .form-step {
            display: none;
            grid-column: span 2;
            animation: fadeIn 0.5s ease forwards;
        }

        .form-step.active {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .form-step.active {
            animation: slideIn 0.4s ease forwards;
        }

        /* 완료 단계 스타일 */
        .completion-container {
            grid-column: span 2;
            text-align: center;
            padding: 30px 0;
        }

        .completion-icon {
            font-size: 60px;
            color: var(--success);
            margin-bottom: 20px;
        }

        .completion-icon i {
            animation: scaleIn 0.5s ease forwards;
        }

        @keyframes scaleIn {
            from {
                transform: scale(0.5);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .completion-container h3 {
            font-size: 24px;
            color: var(--dark);
            margin-bottom: 10px;
        }

        .completion-container p {
            color: var(--gray-500);
            margin-bottom: 30px;
        }

        .user-info-summary {
            background-color: var(--gray-100);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-top: 20px;
            text-align: left;
        }

        .info-row {
            display: flex;
            border-bottom: 1px solid var(--gray-200);
            padding: 10px 0;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            width: 30%;
            font-weight: 500;
            color: var(--secondary);
        }

        .info-value {
            width: 70%;
            color: var(--dark);
        }

        @media (max-width: 768px) {
            form {
                grid-template-columns: 1fr;
            }
            .form-group.full-width,
            .button-group,
            .progress-container,
            .terms-container {
                grid-column: span 1;
            }
            .container {
                margin: 20px;
                padding: 20px;
            }
            .form-step.active {
                grid-template-columns: 1fr;
            }
            .form-row {
                flex-direction: column;
                grid-column: span 1;
            }
        }

        @media (max-width: 480px) {
            .step-label {
                font-size: 10px;
            }

            .container {
                padding: 15px;
            }

            .button-group {
                flex-direction: column;
            }
        }
    </style>
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
                <div class="step active" data-step="1">1<span class="step-label">이용약관 동의</span></div>
                <div class="step" data-step="2">2<span class="step-label">이메일 인증</span></div>
                <div class="step" data-step="3">3<span class="step-label">정보 입력</span></div>
                <div class="step" data-step="4">4<span class="step-label">가입 완료</span></div>
            </div>
        </div>

        <form id="joinForm">
            <!-- 단계 1: 이용약관 동의 -->
            <div class="form-step active" id="step1">
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
                        - 회원 관리: 회원제 서비스 이용에 따른 본인확인, 개인식별, 불량회원의 부정이용 방지와 비인가 사용 방지, 가입의사 확인, 연령확인, 불만처리 등 민원처리, 고지사항
                        전달<br>
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
                    <button type="button" class="btn btn-secondary" onclick="location='/loginView'">뒤로가기</button>
                    <button type="button" class="btn btn-primary next-step" data-next="2">다음 단계</button>
                </div>
            </div>

            <!-- 단계 2: 이메일 인증 -->
            <div class="form-step" id="step2">
                <div class="form-group full-width">
                    <label>이메일 <span class="required-mark">*</span></label>
                    <div class="email-group">
                        <input type="email" name="userEmail" id="userEmail" required placeholder="example@email.com"
                            pattern="^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$"
                            oninvalid="this.setCustomValidity('올바른 이메일 주소 형식으로 입력해주세요.')"
                            oninput="setCustomValidity('')">
                        <button type="button" class="verify-button" id="checkEmail">인증번호 발송</button>
                    </div>
                    <span class="input-hint">이메일 주소를 입력해주세요.</span>
                    <span class="error-message">올바른 이메일 주소 형식으로 입력해주세요.</span>

                    <!-- 인증번호 입력 필드 -->
                    <div id="verificationCodeGroup" class="email-group" style="margin-top: 10px; display: none;">
                        <input type="text" id="verificationCode" placeholder="인증번호 입력" required>
                        <button type="button" class="verify-button" id="verifyEmailBtn">인증 확인</button>
                    </div>
                    <div id="memailconfirmTxt" style="margin-top: 5px;"></div>
                </div>

                <div class="button-group">
                    <button type="button" class="btn btn-secondary prev-step" data-prev="1">이전 단계</button>
                    <button type="button" class="btn btn-primary next-step" data-next="3">다음 단계</button>
                </div>
            </div>

            <!-- 단계 3: 정보 입력 -->
            <div class="form-step" id="step3">
                <div class="form-group">
                    <label>아이디 <span class="required-mark">*</span></label>
                    <input type="text" name="userId" required placeholder="영문, 숫자로 4~12자 입력"
                        pattern="^[a-zA-Z0-9]{4,12}$" oninvalid="this.setCustomValidity('아이디는 영문, 숫자로 4~12자로 입력해주세요.')"
                        oninput="setCustomValidity('')">
                    <span class="input-hint">영문, 숫자를 조합하여 4~12자로 입력해주세요.</span>
                    <span class="error-message">아이디는 영문, 숫자로 4~12자로 입력해주세요.</span>
                </div>

                <div class="form-group">
                    <label>이름 <span class="required-mark">*</span></label>
                    <input type="text" name="userName" required placeholder="한글 2~4자 입력" pattern="^[가-힣]{2,4}$"
                        oninvalid="this.setCustomValidity('이름은 한글 2~4자로 입력해주세요.')" oninput="setCustomValidity('')">
                    <span class="input-hint">한글 2~4자로 입력해주세요.</span>
                    <span class="error-message">이름은 한글 2~4자로 입력해주세요.</span>
                </div>

                <div class="form-group">
                    <label>비밀번호 <span class="required-mark">*</span></label>
                    <input type="password" name="userPw" id="userPw" required placeholder="영문, 숫자, 특수문자 포함 8~16자"
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
                    <input type="password" name="pwdConfirm" id="pwdConfirm" required placeholder="비밀번호를 다시 입력"
                        oninput="checkPasswordMatch(this)">
                    <span class="input-hint">비밀번호를 한번 더 입력해주세요.</span>
                    <span class="error-message" id="pwMatchError">비밀번호가 일치하지 않습니다.</span>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>전화번호 <span class="required-mark">*</span></label>
                        <input type="tel" name="userTel" required placeholder="010-0000-0000"
                            pattern="^010-\d{4}-\d{4}$"
                            oninvalid="this.setCustomValidity('올바른 전화번호 형식(010-0000-0000)으로 입력해주세요.')"
                            oninput="setCustomValidity('')">
                        <span class="input-hint">010-0000-0000 형식으로 입력해주세요.</span>
                        <span class="error-message">올바른 전화번호 형식(010-0000-0000)으로 입력해주세요.</span>
                    </div>

                    <div class="form-group">
                        <label>생년월일 <span class="required-mark">*</span></label>
                        <input type="date" name="userBirth" required oninvalid="this.setCustomValidity('생년월일을 선택해주세요.')"
                            oninput="setCustomValidity('')">
                        <span class="input-hint">생년월일을 선택해주세요.</span>
                        <span class="error-message">생년월일을 선택해주세요.</span>
                    </div>
                </div>

                <div class="form-group full-width">
                    <label>주소 <span class="required-mark">*</span></label>

                    <input type="text" name="userZipCode" id="zipCode" required placeholder="우편번호 입력"
                        oninvalid="this.setCustomValidity('우편번호를 선택해주세요.')" oninput="setCustomValidity('')">


                    <span class="input-hint">우편번호를 입력해주세요.</span>
                    <span class="error-message">우편번호를 입력해주세요.</span>
                    <div class="address-search">
                        <input type="text" name="userAddress" id="userAddress" required placeholder="도로명 또는 지번 주소 입력"
                            oninvalid="this.setCustomValidity('주소를 입력해주세요.')" oninput="setCustomValidity('')">
                        <button type="button" onclick="searchAddress()">주소 검색</button>
                    </div>
                    <span class="input-hint">도로명 또는 지번 주소를 입력해주세요.</span>
                    <span class="error-message">주소를 입력해주세요.</span>
                </div>

                <div class="form-group full-width">
                    <label>상세 주소</label>
                    <input type="text" name="userDetailAddress" placeholder="상세 주소 입력 (선택사항)">
                    <span class="input-hint">아파트/호수 등 상세 주소를 입력해주세요.</span>
                </div>

                <div class="button-group">
                    <button type="button" class="btn btn-secondary prev-step" data-prev="2">이전 단계</button>
                    <button type="button" class="btn btn-primary next-step" data-next="4">다음 단계</button>
                </div>
            </div>

            <!-- 단계 4: 가입 완료 -->
            <div class="form-step" id="step4">
                <div class="completion-container">
                    <div class="completion-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h3>회원가입 정보 확인</h3>
                    <p>입력하신 정보를 확인하시고 가입 버튼을 클릭하세요.</p>
                    
                    <div class="user-info-summary">
                        <div class="info-row">
                            <div class="info-label">아이디</div>
                            <div class="info-value" id="summary-userId"></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">이름</div>
                            <div class="info-value" id="summary-userName"></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">이메일</div>
                            <div class="info-value" id="summary-userEmail"></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">전화번호</div>
                            <div class="info-value" id="summary-userTel"></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">주소</div>
                            <div class="info-value" id="summary-userAddress"></div>
                        </div>
                    </div>
                </div>

                <div class="button-group">
                    <button type="button" class="btn btn-secondary prev-step" data-prev="3">이전 단계</button>
                    <button type="button" class="btn btn-primary" onclick="fn_submit()">회원가입</button>
                </div>
            </div>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            // 단계별 진행 관리
            let currentStep = 1;
            updateProgressBar(currentStep);

            // 이메일 인증 관련 변수
            let emailVerificationSent = false; // 인증번호 발송 여부
            let emailVerified = false; // 이메일 인증 완료 여부
            let serverCode = ""; // 서버에서 받은 인증번호
            let isButtonDisabled = false; // 버튼 클릭 제한 변수

            // 다음 단계 버튼 클릭 이벤트
            $(".next-step").on("click", function() {
                const nextStep = parseInt($(this).data("next"));

                // 현재 단계 유효성 검사
                if (validateStep(currentStep)) {
                    // 현재 단계 완료 표시
                    $(".step[data-step='" + currentStep + "']")
                        .removeClass("active")
                        .addClass("completed")
						.html('<span class="step-label">' + $(".step[data-step='" + currentStep + "'] .step-label").text() + '</span>');
						
						// 체크 표시 추가
						        $(".step[data-step='" + currentStep + "']").append('<i class="fas fa-check"></i>');

						        // 다음 단계 활성화
						        $(".step[data-step='" + nextStep + "']").addClass("active");
                    // 다음 단계 활성화
                    $(".step[data-step='" + nextStep + "']").addClass("active");

                    // 폼 단계 전환
                    $(".form-step").removeClass("active");
                    $("#step" + nextStep).addClass("active");

                    // 현재 단계 업데이트
                    currentStep = nextStep;

                    // 진행 바 업데이트
                    updateProgressBar(currentStep);

                    // 마지막 단계에서는 입력 정보 요약 표시
                    if (currentStep === 4) {
                        updateSummary();
                    }

                    // 페이지 상단으로 스크롤
                    scrollToTop();
                }
            });

            // 이전 단계 버튼 클릭 이벤트
            $(".prev-step").on("click", function() {
                const prevStep = parseInt($(this).data("prev"));

                // 현재 단계 비활성화
                $(".step[data-step='" + currentStep + "']").removeClass("active");

                // 이전 단계 활성화 (완료 표시 유지)
                $(".step[data-step='" + prevStep + "']")
                    .removeClass("completed")
                    .addClass("active");

                // 폼 단계 전환
                $(".form-step").removeClass("active");
                $("#step" + prevStep).addClass("active");

                // 현재 단계 업데이트
                currentStep = prevStep;

                // 진행 바 업데이트
                updateProgressBar(currentStep);

                // 페이지 상단으로 스크롤
                scrollToTop();
            });

            // 진행 바 업데이트 함수
            function updateProgressBar(step) {
                const totalSteps = 4;
                const progressPercentage = ((step - 1) / (totalSteps - 1)) * 100;
                document.documentElement.style.setProperty('--progress-width', progressPercentage + '%');
            }

            // 단계별 유효성 검사 함수
            function validateStep(step) {
                switch (step) {
                    case 1:
                        // 약관 동의 확인
                        if (!$("#termsAgree").is(":checked")) {
                            alert("이용약관에 동의해주세요.");
                            return false;
                        }
                        if (!$("#privacyAgree").is(":checked")) {
                            alert("개인정보 수집 및 이용에 동의해주세요.");
                            return false;
                        }
                        return true;

                    case 2:
                        // 이메일 인증 확인
                        if (!emailVerified) {
                            alert("이메일 인증을 완료해주세요.");
                            return false;
                        }
                        return true;

                    case 3:
                        // 필수 입력 필드 확인
                        const requiredFields = $("#step3 input[required]");
                        let isValid = true;

                        requiredFields.each(function() {
                            if (!$(this).val()) {
                                const fieldName = $(this).prev("label").text().replace("*", "").trim();
                                alert(fieldName + "을(를) 입력해주세요.");
                                $(this).focus();
                                isValid = false;
                                return false; // each 루프 중단
                            }
                        });

                        if (!isValid) return false;

                        // 비밀번호 일치 확인
                        const password = $("#userPw").val();
                        const confirmPassword = $("#pwdConfirm").val();

                        if (password !== confirmPassword) {
                            alert("비밀번호가 일치하지 않습니다.");
                            $("#pwdConfirm").focus();
                            return false;
                        }

                        return true;

                    default:
                        return true;
                }
            }

            // 요약 정보 업데이트 함수
            function updateSummary() {
                $("#summary-userId").text($("input[name='userId']").val());
                $("#summary-userName").text($("input[name='userName']").val());
                $("#summary-userEmail").text($("input[name='userEmail']").val());
                $("#summary-userTel").text($("input[name='userTel']").val());

                const address = $("input[name='userZipCode']").val() + " " + $("input[name='userAddress']").val();
                const detailAddress = $("input[name='userDetailAddress']").val();

                if (detailAddress) {
                    $("#summary-userAddress").text(address + " " + detailAddress);
                } else {
                    $("#summary-userAddress").text(address);
                }
            }

            // 페이지 상단으로 스크롤 함수
            function scrollToTop() {
                $("html, body").animate({
                    scrollTop: $(".progress-container").offset().top - 20
                }, 300);
            }

            // 인증번호 발송 버튼 클릭 이벤트
            $("#checkEmail").click(function() {
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
                let countdown = 5;

                $button.prop("disabled", true)
                    .addClass("disabled")
                    .css("opacity", "0.7")
                    .text(countdown + "초 후 재시도");

                // 카운트다운 타이머 시작
                const countdownInterval = setInterval(function() {
                    countdown--;
                    $button.text(countdown + "초 후 재시도");

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
                    success: function(data) {
                        alert("해당 이메일로 인증번호 발송이 완료되었습니다.");
                        console.log("받은 인증코드: " + data);

                        // 인증번호 입력 필드 표시
                        $("#verificationCodeGroup").show();
                        emailVerificationSent = true;

                        // 서버에서 받은 인증번호 저장
                        serverCode = data.trim();
                    },
                    error: function(xhr, status, error) {
                        alert("이메일 발송 중 오류가 발생했습니다. 다시 시도해주세요.");
                        console.error("이메일 발송 오류:", xhr.status, error);
                        console.log("응답 텍스트:", xhr.responseText);
                    }
                });
            });

            // 인증 확인 버튼 클릭 이벤트
            $("#verifyEmailBtn").click(function() {
                const inputCode = $("#verificationCode").val();

                if (!inputCode) {
                    alert("인증번호를 입력해주세요.");
                    return;
                }

                const isValid = serverCode === inputCode;

                updateVerificationStatus(isValid);

                if (isValid) {
                    alert("이메일 인증이 완료되었습니다.");
                } else {
                    alert("인증번호가 일치하지 않습니다. 다시 확인해주세요.");
                }
            });

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
                    $("#checkEmail").prop("disabled", true).css("opacity", "0.5");
                    $("#verifyEmailBtn").prop("disabled", true).css("opacity", "0.5");
                }
            }
        });

        // 주소 검색 함수
        function searchAddress() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 우편번호와 도로명 주소 설정
                    const zipCode = document.getElementById("zipCode");
                    const userAddress = document.getElementById("userAddress");

                    zipCode.value = data.zonecode;
                    userAddress.value = data.roadAddress;

                    zipCode.readOnly = true;
                    userAddress.readOnly = true;
                }
            }).open();
        }

        // 비밀번호 일치 확인 함수
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

        // 비밀번호 강도 확인 함수
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

        // 폼 제출 함수
        function fn_submit() {
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
                success: function(data) {
                    alert("회원가입이 정상적으로 처리되었습니다.");
                    location.href = "loginForm";
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
</body>

</html>
