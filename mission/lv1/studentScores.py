#심화 연습 문제
scores_data = """ 학생1: 홍길동, 성적: 85
학생2: 김철수, 성적: 90
학생3: 이영희, 성적: 78
학생4: 박민지, 성적: 92
학생5: 최준호, 성적: 88"""

students_data = scores_data.strip().split('\n')


names = [] # 이름
scores = [] # 점수

for student_info in students_data:
    parts = student_info.split(': ', 1)[1] #학생n 빼기 
    print(parts)
    name, score = parts.split(', 성적: ')
    
    names.append(name)
    scores.append(int(score))

print("학생 이름:", names)
print("학생 성적:", scores)

#평균 점수 계산
average_score = sum(scores) / len(scores)
print(f"평균 점수: {average_score:.2f}")