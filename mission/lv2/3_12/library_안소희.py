# 종이책 클래스
class Book:
    # 생성자
    def __init__(self, title, author, is_borrowed=False):
        self.title = title
        self.author = author
        self.is_borrowed = is_borrowed

    # 대출 메서드
    def borrow(self):
        if self.is_borrowed: # 대출중이면 예외 발생
            raise ValueError()
        self.is_borrowed = True # 대출 상태로 변경

    # 반납 메서드
    def return_book(self):
        if not self.is_borrowed: # 대출되지 않은 상태면 예외 발생
            raise ValueError()
        self.is_borrowed = False # 대출 가능 상태로 변경
    
    # 문자열
    def __str__(self):
        return f"[종이책] {self.title} - {self.author} (대출 여부: {'대출중' if self.is_borrowed else '가능'})"
    
# 전자책 클래스
class Ebook(Book):
    #생성자
    def __init__(self, title, author, file_size, is_borrowed=False):
        super().__init__(title, author, is_borrowed)
        self.file_size = file_size

    # 전자책 다운로드 메서드
    def download(self):
        print(f"📥 {self.title} 다운로드 완료! ({self.file_size}MB)")

    # 문자열
    def __str__(self):
        return f"[전자책] {self.title} - {self.author} (파일 크기: {self.file_size}MB, 대출 여부: {'대출중' if self.is_borrowed else '가능'})"

# 도서관 클래스
class Library:
    #생성자
    def __init__(self):
        self.books = [] # 책목록
        self.load_books() # books.txt파일에서 책 정보 불러오기
    
    # 책 추가
    def add_book(self, book):
        self.books.append(book)
        self.save_books() # 변경된 책 목록 파일에 저장
    
    #제목으로 책 찾기
    def find_book(self, title):
        for book in self.books:
            if book.title == title:
                return book # 제목과 일치하는 책 리턴
        return  # 일치하는 책이 없으면 none

    # 책 대출 처리
    def borrow_book(self, title):
        book = self.find_book(title) # 제목으로 책 찾기
        if not book: # 책 없으면
            print("⚠ 해당 책이 없습니다!")
            return
        try:
            book.borrow() # 책 대출
            self.save_books() # 저장
            print(f"📖 {title} 대출완료")
        except ValueError: # 이미 대출중인 경우
            print("⚠ 이미 대출된 책입니다!")
    
    # 책 반납 처리
    def return_book(self, title):
        book = self.find_book(title) # 제목으로 책 찾기
        if not book: # 책 없으면
            print("⚠ 해당 책이 없습니다!")
            return
        try:
            book.return_book() # 책 반납
            self.save_books() # 저장
            print(f"📖 {title} 반납 완료!")
        except ValueError: # 대출되지 않은 경우
            print("⚠ 대출되지 않은 책입니다.")

    # 책 목록 출력
    def show_books(self):
        print("\n도서 목록:")
        if not self.books: # 책 없으면
            print("등록된 책이 없습니다.")
            return
        # 종이책    
        paper_books = [b for b in self.books if isinstance(b, Book) and not isinstance(b, Ebook)]
        # 전자책 
        ebooks = [b for b in self.books if isinstance(b, Ebook)]

        print("\n종이책:")
        if paper_books:
            for book in paper_books:
                print(f"- {book}")
        else:
            print("등록된 종이책이 없습니다.")

        print("\n전자책:")
        if ebooks:
            for book in ebooks:
                print(f"- {book}")
        else:
            print("등록된 전자책이 없습니다.")

    # 전자책 다운로드
    def download_ebook(self, title):
        book = self.find_book(title) # 제목으로 책 찾기
        if not book:
            print("⚠ 해당 책이 없습니다!")
        elif isinstance(book, Ebook):# 전자책이면
            book.download() # 다운로드
        else: # 종이책이면
            print("⚠ 종이책은 다운로드할 수 없습니다!")
    
    # books.txt파일에서 책 정보 불러오기
    def load_books(self):
        try:
            with open('books.txt', 'r', encoding='utf-8') as f:
                for line in f:
                    parts = line.strip().split('|') # 구분자로 데이터 분리
                    
                    if len(parts) < 4:  
                        continue
                        
                    book_type = parts[0] # 종류
                    title = parts[1] # 제목
                    author = parts[2] # 저자
                    is_borrowed = parts[3] == 'True' # 대출현황

                   # 책 종류에 따라 객체 생성
                    if book_type == 'ebook': # 전자책이면
                        if len(parts) >= 5:  
                            try:
                                file_size = int(parts[4])
                                self.books.append(Ebook(title, author, file_size, is_borrowed))
                            except ValueError:
                                # 파일 크기가 정수가 아닌 경우
                                continue
                    else: # 종이책이면
                        self.books.append(Book(title, author, is_borrowed))
        except FileNotFoundError:
            # 파일이 없으면 빈 리스트로 시작
            pass

    # 책 정보를 파일에 저장
    def save_books(self):
        try:
            with open('books.txt', 'w', encoding='utf-8') as f:
                for book in self.books:
                    # 공통 필드
                    line = [
                        'ebook' if isinstance(book, Ebook) else 'book',
                        book.title,
                        book.author,
                        str(book.is_borrowed)
                    ]
                    
                    # 전자책 추가 필드
                    if isinstance(book, Ebook):
                        line.append(str(book.file_size))
                        
                    f.write('|'.join(line) + '\n')
        except Exception as e:
            print(f"⚠ 파일 저장 중 오류 발생: {e}")

def main():
    library = Library() # 도서관 객체 생성
    while True:
        print("\n📚 도서 관리 시스템 📚")
        print("1.종이책 추가\n2.전자책 추가\n3.책 대출\n4.책 반납\n5.전자책 다운로드\n6.책 목록 보기\n7.종료")
        choice = input("선택: ")
        if choice == '1':
            title = input("종이책 제목: ")
            author = input("저자: ")
            library.add_book(Book(title,author))
            print("[종이책 등록 완료]")

        elif choice == '2':
            title = input("전자책 제목: ")
            author = input("저자: ")
            file_size = input("파일 크기(MB):")
            library.add_book(Ebook(title,author,int(file_size)))
            print("[전자책 등록 완료]")

        elif choice == '3':
            title = input("대출하실 책제목: ")
            library.borrow_book(title)

        elif choice == '4':
            title = input("반납하실 책제목: ")
            library.return_book(title)

        elif choice == '5':
            title = input("다운로드할 전자책 제목: ")
            library.download_ebook(title)

        elif choice == '6':
            library.show_books()
        
        elif choice == '7':
            print("시스템 종료합니다")
            break

        else:
            print("⚠ 잘못된 입력입니다")


    
main()