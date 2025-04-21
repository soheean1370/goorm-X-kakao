from log_analysis import *

logs = load_logs(r"log.txt")
log_data = parse_logs(logs)

print(get_user_activity(log_data, "user123"))
save_summary(log_data, "summary.txt")
