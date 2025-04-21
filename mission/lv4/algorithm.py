# 재귀 알고리즘

n=int(input())

def hanoi(n, start, mid, end):
    if n == 1:
        print(start,end)
    else:
        hanoi(n-1, start, end, mid)
        print(start,end)
        hanoi(n-1,mid,start,end)

print(2**n-1)
hanoi(n,1,2,3)
print('---------------------------------')

# 그래프 탐색 알고리즘 구현 
def DFS(g,v,visited):
	visited[v] = True
	print(v,end =' ')
	for i in g[v]:
		if not visited[i]:
			DFS(g,i,visited)
g =[
	[],
	[2,3,8],
	[1,7],
	[1,4,5],
	[3,5],
	[3,4],
	[7],
	[2,6,8],
	[1,7],
]

visited = [False] * 9

print('DFS')
DFS(g,1,visited)
# BFS
from collections import deque

def BFS(graph,start,visited):
	queue = deque([start])
	visited[start] = True

	while queue:
		v = queue.popleft()
		print(v,end=' ')
		for i in graph[v]:
			if not visited[i]:
				queue.append(i)
				visited[i] = True

g =[
	[],
	[2,3,8],
	[1,7],
	[1,4,5],
	[3,5],
	[3,4],
	[7],
	[2,6,8],
	[1,7],
]
visited = [False] * 9
print('\nBFS')
BFS(g,1,visited)

# queue/stack 구현

class Queue:
    def __init__(self):
        self.data = []
    
    def enqueue(self, value):
        self.data.append(value)
        
    def dequeue(self):
        if not self.is_empty():
            return self.data.pop(0)
        else:
            return None
    
    def front(self):
        if not self.is_empty():
            return self.data[0]
        else:
            return None
    
    def is_empty(self):
        return len(self.data) == 0
    
    def size(self):
        return len(self.data)
    
    def __str__(self):
        return str(self.data)


class Stack:
    def __init__(self):
        self.data = []
    
    def push(self, value):
        self.data.append(value)
        
    def pop(self):
        if not self.is_empty():
            return self.data.pop()
        else:
            return None
    
    def top(self):
        if not self.is_empty():
            return self.data[-1]
        else:
            return None
    
    def is_empty(self):
        return len(self.data) == 0
    
    def size(self):
        return len(self.data)
    
    def __str__(self):
        return str(self.data)


if __name__ == "__main__":
    queue = Queue()
    stack = Stack()
    
    while True:
        print("\n=== 자료구조 선택 ===")
        print("1. 큐(Queue)")
        print("2. 스택(Stack)")
        print("0. 종료")
        
        choice = input("선택하세요: ")
        
        if choice == "0":
            print("프로그램을 종료합니다.")
            break
            
        elif choice == "1":  # 큐 작업
            while True:
                print("\n=== 큐 작업 ===")
                print("1. 삽입(Enqueue)")
                print("2. 삭제(Dequeue)")
                print("3. 맨 앞 요소 확인(Front)")
                print("4. 크기 확인")
                print("5. 내용 출력")
                print("0. 이전 메뉴로")
                
                op = input("작업을 선택하세요: ")
                
                if op == "0":
                    break
                elif op == "1":
                    value = input("삽입할 값: ")
                    queue.enqueue(value)
                    print(f"'{value}'을(를) 큐에 삽입했습니다.")
                elif op == "2":
                    result = queue.dequeue()
                    if result is not None:
                        print(f"삭제된 값: {result}")
                    else:
                        print("큐가 비어 있습니다.")
                elif op == "3":
                    result = queue.front()
                    if result is not None:
                        print(f"맨 앞 요소: {result}")
                    else:
                        print("큐가 비어 있습니다.")
                elif op == "4":
                    print(f"큐의 크기: {queue.size()}")
                elif op == "5":
                    print(f"큐의 내용: {queue}")
                else:
                    print("잘못된 선택입니다.")
                    
        elif choice == "2":  # 스택 작업
            while True:
                print("\n=== 스택 작업 ===")
                print("1. 삽입(Push)")
                print("2. 삭제(Pop)")
                print("3. 맨 위 요소 확인(Top)")
                print("4. 크기 확인")
                print("5. 내용 출력")
                print("0. 이전 메뉴로")
                
                op = input("작업을 선택하세요: ")
                
                if op == "0":
                    break
                elif op == "1":
                    value = input("삽입할 값: ")
                    stack.push(value)
                    print(f"'{value}'을(를) 스택에 삽입했습니다.")
                elif op == "2":
                    result = stack.pop()
                    if result is not None:
                        print(f"삭제된 값: {result}")
                    else:
                        print("스택이 비어 있습니다.")
                elif op == "3":
                    result = stack.top()
                    if result is not None:
                        print(f"맨 위 요소: {result}")
                    else:
                        print("스택이 비어 있습니다.")
                elif op == "4":
                    print(f"스택의 크기: {stack.size()}")
                elif op == "5":
                    print(f"스택의 내용: {stack}")
                else:
                    print("잘못된 선택입니다.")
                    
        else:
            print("잘못된 선택입니다.")
