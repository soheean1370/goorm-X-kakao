menu = [("Pizza", 12000),("Burger", 8000),("Pasta", 15000),("Sushi", 20000),("Salad", 6000)]
total = 0
print("메뉴판")
for i in range(len(menu)):
    print(f" {i+1}. {menu[i][0]} - {menu[i][1]}원 ")
    
    
lst = input("\n주문할 음식을 입력하세요(쉼표로 구분): " )
foods = lst.strip().split(",")
print("\n주문내역")
for i,food in enumerate(foods):
    food = food.strip()
    price = 0
    for item in menu:
        if item[0].lower() == food.lower():
            food = item[0]
            price = item[1]
            break
    if price > 0 :
        print(f"{i+1}. {food} - {price}원")
    else:
        print(f"{i+1}. 메뉴판에 없는 음식입니다")
    total += price

print("\n총 가격")
print(f"총: {total}원")