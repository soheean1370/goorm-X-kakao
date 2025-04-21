# 주어진 log.txt 파일을 읽고, 각 줄을 리스트에 저장하여 반환하는 함수
def load_logs(filename: str) -> list:
    log_lines = []
    with open(filename, 'r') as f:
        for line in f:
            log_lines.append(line.strip())
    return log_lines

# log_lines 리스트를 받아서, {날짜: {사용자ID: [활동들]}} 형식의 딕셔너리로 변환하는 함수
def parse_logs(log_lines: list) -> dict:
    log_data = {}
    for line in log_lines:
        parts = line.split()
        if len(parts) >= 3:
            date = parts[0]
            user_id = parts[1]
            activity = parts[2]

            #날짜가 딕셔너리에 없으면 초기화
            if date not in log_data:
                log_data[date] = {}

            # 사용자 ID가 날짜 내부 딕셔너리에 없으면 초기화
            if user_id not in log_data[date]:
                log_data[date][user_id] = []

            log_data[date][user_id].append(activity)
    return log_data


# 특정 사용자의 모든 활동 내역을 날짜별로 반환하는 함수
def get_user_activity(log_data: dict, user_id: str) -> dict:
    user_activity = {}
    for date,users in log_data.items():
        if user_id in users:
            user_activity[date] = users[user_id]
    return user_activity

# 날짜별 사용자 활동 내역을 파일(summary.txt)로 저장하는 함수
def save_summary(log_data: dict, filename: str) -> None:
    with open(filename, 'w') as f:
        for date, users in log_data.items():  # 각 날짜와 사용자 활동을 순회
            f.write(f"{date}\n")  # 날짜를 파일에 쓰기
            for user_id, activities in users.items():  # 각 사용자와 활동을 순회
                # 활동을 문자열로 변환 (예: "login, logout")
                activity_str = ", ".join(activities)
                f.write(f"{user_id}: {activity_str}\n")  # 사용자 활동을 파일에 쓰기
            f.write("#\n")  # 날짜 구분자 추가
