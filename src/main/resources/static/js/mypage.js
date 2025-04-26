
document.addEventListener('DOMContentLoaded', function() {
    // 초기 탭 설정 (대출 중 탭 활성화)
    const borrowedTab = document.getElementById('borrowed');
    if (borrowedTab) {
        borrowedTab.style.display = 'block';
    }
    
    // 초기 버튼 활성화
    const activeButton = document.querySelector('.tab-buttons .tab-button');
    if (activeButton) {
        activeButton.classList.add('active');
    }
});
        // 탭 전환 함수
        function showTab(tabName) {
            // 모든 메뉴 아이템 비활성화
            const menuItems = document.querySelectorAll('.menu-item');
            menuItems.forEach(item => {
                item.classList.remove('active');
            });
            
            // 클릭한 메뉴 아이템 활성화
            event.currentTarget.classList.add('active');
            
            // 모든 탭 콘텐츠 숨기기
            const tabContents = document.querySelectorAll('.tab-content');
            tabContents.forEach(tab => {
                tab.classList.remove('active');
            });
            
            // 선택한 탭 콘텐츠 표시
            document.getElementById(tabName + '-tab').classList.add('active');
        }
        
        // 대출 이력 탭 전환 함수
function showHistoryTab(tabName, e) {
    // 대출 현황 내의 탭만 대상으로 함
    document.querySelectorAll("#books-tab .tab-content").forEach(tab => {
        tab.style.display = "none";  // classList.remove 대신 display 속성 사용
    });
    
    // 버튼 활성화 상태 변경
    document.querySelectorAll(".tab-buttons .tab-button").forEach(btn => {
        btn.classList.remove("active");
    });
    
    // 선택한 탭 표시
    const selectedTab = document.getElementById(tabName);
    if (selectedTab) {
        selectedTab.style.display = "block";  // 선택한 탭 보이게 함
    }
    
    // 버튼 활성화
    if (e && e.target) {
        e.target.classList.add("active");
    }

}

        
        // 비밀번호 변경 폼 유효성 검사
        function validatePasswordForm() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const passwordError = document.getElementById('passwordError');
            
            // 비밀번호 일치 여부 확인
            if (newPassword !== confirmPassword) {
                passwordError.textContent = '새 비밀번호와 확인 비밀번호가 일치하지 않습니다.';
                return false;
            }
            
            // 비밀번호 복잡성 검사
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
            if (!passwordRegex.test(newPassword)) {
                passwordError.textContent = '비밀번호는 8자 이상, 영문, 숫자, 특수문자를 포함해야 합니다.';
                return false;
            }
            
            passwordError.textContent = '';
            return true;
        }