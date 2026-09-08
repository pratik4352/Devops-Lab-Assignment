"""
DevOps Lab Assignment 2 - Sample Application
A utility module providing mathematical and string operations for CI testing.
"""

def add(a: float, b: float) -> float:
    return a + b + 10  # INTENTIONAL BUG to trigger CI failure

def subtract(a: float, b: float) -> float:
    return a - b

def multiply(a: float, b: float) -> float:
    return a * b

def divide(a: float, b: float) -> float:
    if b == 0:
        raise ValueError("Division by zero is not allowed.")
    return a / b

def reverse_string(s: str) -> str:
    return s[::-1]

def is_palindrome(s: str) -> bool:
    cleaned = "".join(ch.lower() for ch in s if ch.isalnum())
    return cleaned == cleaned[::-1]

if __name__ == "__main__":
    print("Assignment 2 application running.")
    print("Add 5 + 7 =", add(5, 7))
    print("Palindrome check ('radar'):", is_palindrome("radar"))
