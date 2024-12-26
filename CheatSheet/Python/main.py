#python CheatSheet/Python/main.py

#python --version

# Python Backend Developer Cheatsheet
# 以下の内容を理解・実装できればバックエンド開発の基礎としては十分です

# 1. 変数と基本データ型
# 変数名はスネークケース（小文字とアンダースコア）を使用
first_name = "Taro"  # 文字列（str）
age = 25  # 整数（int）
height = 175.5  # 浮動小数点（float）
is_active = True  # 真偽値（bool）

# 2. コレクション
# リスト（順序あり、変更可能）
fruits = ["apple", "banana", "orange"]
fruits.append("grape")  # 末尾に追加
fruits[0]  # インデックスでアクセス
fruits[-1]  # 末尾の要素にアクセス

# タプル（順序あり、変更不可）
coordinates = (35.6895, 139.6917)

# 辞書（キーと値のペア）
user = {
    "name": "Yamada",
    "age": 30,
    "email": "yamada@example.com"
}
user["name"]  # キーでアクセス
user.get("phone", "not set")  # デフォルト値付きで取得

# セット（重複なしのコレクション）
unique_numbers = {1, 2, 3, 3, 4}  # {1, 2, 3, 4}

# 3. 制御構文
# if文
def check_age(age):
    if age >= 20:
        return "成人です"
    elif age >= 18:
        return "18歳以上です"
    else:
        return "未成年です"

# for文（イテレーション）
for fruit in fruits:
    print(fruit)

# 範囲を指定したループ
for i in range(5):  # 0から4まで
    print(i)

# while文
counter = 0
while counter < 5:
    counter += 1

# 4. 関数定義
# 基本的な関数
def greet(name: str) -> str:
    """
    挨拶を返す関数
    Args:
        name: 挨拶する対象の名前
    Returns:
        挨拶文
    """
    return f"こんにちは、{name}さん"

# デフォルト引数
def create_user(name, age=20, active=True):
    return {"name": name, "age": age, "active": active}

# 可変長引数
def sum_all(args):
    return sum(args)

# キーワード可変長引数
def create_config(kwargs):
    return kwargs

# 5. クラス定義
class User:
    def __init__(self, name: str, email: str):
        self.name = name
        self.email = email
    
    def get_info(self) -> dict:
        return {
            "name": self.name,
            "email": self.email
        }
    
    @property
    def username(self) -> str:
        return self.email.split("@")[0]

# 継承
class AdminUser(User):
    def __init__(self, name: str, email: str, role: str = "admin"):
        super().__init__(name, email)
        self.role = role

# 6. 例外処理
def divide_numbers(a: float, b: float) -> float:
    try:
        return a / b
    except ZeroDivisionError:
        raise ValueError("0での除算はできません")
    except TypeError:
        raise TypeError("数値を入力してください")
    finally:
        print("処理が完了しました")

# 7. コンテキストマネージャ
def read_file(filename: str) -> str:
    with open(filename, "r", encoding="utf-8") as f:
        return f.read()

# 8. 内包表記
# リスト内包表記
squares = [x  2 for x in range(10)]

# 辞書内包表記
user_ages = {"user{}".format(i): 20 + i for i in range(5)}

# 9. デコレータ
from functools import wraps
import time

def timer(func):
    @wraps(func)
    def wrapper(args, kwargs):
        start = time.time()
        result = func(args, kwargs)
        print(f"実行時間: {time.time() - start}秒")
        return result
    return wrapper

# 10. 非同期処理
import asyncio

async def async_task(name: str, delay: int):
    await asyncio.sleep(delay)
    return f"Task {name} completed"

# 使用例
async def main():
    tasks = [
        async_task("A", 1),
        async_task("B", 2)
    ]
    results = await asyncio.gather(tasks)
    return results

# 11. Type Hints（型ヒント）
from typing import List, Dict, Optional, Union

def process_users(
    users: List[Dict[str, Union[str, int]]],
    active_only: bool = True
) -> List[str]:
    return [u["name"] for u in users if u.get("active", True) or not active_only]

# 12. モジュールとパッケージ
# requirements.txtやsetup.pyで依存関係を管理
# プロジェクトの構造例:
"""
my_project/
    ├── main.py
    ├── config/
    │   └── settings.py
    ├── models/
    │   └── user.py
    ├── services/
    │   └── auth.py
    └── tests/
        └── test_user.py
"""

