"""
Unit Tests for Assignment 2 Application
Tested with standard Python unittest and compatible with Pytest.
"""

import unittest
from app import add, subtract, multiply, divide, reverse_string, is_palindrome

class TestAppOperations(unittest.TestCase):
    def test_addition(self):
        self.assertEqual(add(10, 5), 15)
        self.assertEqual(add(-1, 1), 0)
        self.assertEqual(add(-5, -5), -10)

    def test_subtraction(self):
        self.assertEqual(subtract(10, 4), 6)
        self.assertEqual(subtract(5, 10), -5)

    def test_multiplication(self):
        self.assertEqual(multiply(3, 4), 12)
        self.assertEqual(multiply(-2, 3), -6)
        self.assertEqual(multiply(0, 100), 0)

    def test_division(self):
        self.assertEqual(divide(20, 5), 4)
        self.assertEqual(divide(7, 2), 3.5)

    def test_division_by_zero(self):
        with self.assertRaises(ValueError):
            divide(10, 0)

    def test_reverse_string(self):
        self.assertEqual(reverse_string("hello"), "olleh")
        self.assertEqual(reverse_string("DevOps"), "spOveD")

    def test_palindrome(self):
        self.assertTrue(is_palindrome("racecar"))
        self.assertTrue(is_palindrome("A man a plan a canal Panama"))
        self.assertFalse(is_palindrome("github"))

if __name__ == "__main__":
    unittest.main()
