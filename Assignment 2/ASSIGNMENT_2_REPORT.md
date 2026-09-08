# Assignment 2: Continuous Integration Using GitHub Actions

**Course / Module:** DevOps Lab & CI/CD Pipelines  
**Author:** Pratik Ghavate (`pratik4352`)  
**GitHub Repository:** [https://github.com/pratik4352/Devops-Lab-Assignment](https://github.com/pratik4352/Devops-Lab-Assignment)  
**Workflow File:** [`.github/workflows/assignment2-ci.yml`](https://github.com/pratik4352/Devops-Lab-Assignment/blob/main/.github/workflows/assignment2-ci.yml)  
**Actions Tab:** [https://github.com/pratik4352/Devops-Lab-Assignment/actions](https://github.com/pratik4352/Devops-Lab-Assignment/actions)  

---

## 1. Introduction to Continuous Integration (CI)

**Continuous Integration (CI)** is a foundational DevOps software engineering practice where developers regularly merge their code alterations into a shared central repository. Rather than integrating software late in the development cycle, automated workflows immediately build, lint, and run automated unit tests against incoming changes.

This "shift-left" approach catches regressions, formatting inconsistencies, and broken builds within minutes of committing code, drastically reducing the cost and complexity of debugging.

### GitHub Actions Architecture & Core Components

GitHub Actions enables native, event-driven CI/CD directly inside any GitHub repository. Its core conceptual components are:

```mermaid
graph TD
    A["Event Trigger (on: push, pull_request)"] --> B["Workflow (.github/workflows/assignment2-ci.yml)"]
    subgraph GitHub Runner ("ubuntu-latest")
        B --> C["Job (build-and-test)"]
        C --> S1["Step 1: actions/checkout@v4 (Action)"]
        C --> S2["Step 2: actions/setup-python@v5 (Action)"]
        C --> S3["Step 3: pip install dependencies (Command)"]
        C --> S4["Step 4: flake8 linting (Command)"]
        C --> S5["Step 5: pytest execution (Command)"]
        C --> S6["Step 6: print execution metadata (Command)"]
    end
    S5 --> D["Status Notification (Success / Failure on GitHub)"]
```

| Component | Definition & Role |
| :--- | :--- |
| **Workflow** | Defines the automated, end-to-end process written in YAML and stored in `.github/workflows/`. |
| **Event (`on:`)** | Specifies the exact condition or activity that triggers workflow execution (e.g., `push` to `main`, `pull_request`, or manual `workflow_dispatch`). |
| **Job** | A group of sequential steps executed together on the same runner. Jobs run in parallel by default unless dependencies are declared (`needs:`). |
| **Step** | An individual task within a job. It can run a shell command (`run:`) or invoke an external reusable component (`uses:`). |
| **Runner (`runs-on:`)** | The host server/virtual machine (such as `ubuntu-latest`, `windows-latest`, or self-hosted) in which the job executes. |
| **Action (`uses:`)** | A packaged, reusable component designed to execute a specific task (e.g., `actions/checkout@v4` or `actions/setup-python@v5`). |

---

## 2. GitHub Actions Workflow Configuration

To automate integration testing for Assignment 2, a dedicated workflow was created at [`.github/workflows/assignment2-ci.yml`](https://github.com/pratik4352/Devops-Lab-Assignment/blob/main/.github/workflows/assignment2-ci.yml):

```yaml
name: Assignment 2 - Continuous Integration

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:

jobs:
  build-and-test:
    name: Build, Lint, and Run Unit Tests
    runs-on: ubuntu-latest

    steps:
      - name: 1. Checkout Repository Code
        uses: actions/checkout@v4

      - name: 2. Set Up Python 3.12 Runtime
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'
          cache: 'pip'

      - name: 3. Install Application Dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r "Assignment 2/requirements.txt"

      - name: 4. Static Code Analysis and Linting (Flake8)
        run: |
          # Terminate build on Python syntax errors or undefined symbols
          flake8 "Assignment 2" --count --select=E9,F63,F7,F82 --show-source --statistics
          # Treat all styling warnings as exit-zero to report metrics
          flake8 "Assignment 2" --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics

      - name: 5. Execute Automated Test Suite (Pytest)
        run: |
          pytest "Assignment 2" -v --junitxml=test-results.xml

      - name: 6. Execution Status Confirmation
        if: always()
        run: |
          echo "========================================="
          echo "Workflow Run ID   : ${{ github.run_id }}"
          echo "Triggered By      : ${{ github.actor }}"
          echo "Event Type        : ${{ github.event_name }}"
          echo "Execution Result  : ${{ job.status }}"
          echo "========================================="
```

---

## 3. Practical Implementation & Verification

### 3.1 Application Code: `Assignment 2/app.py`
A modular Python utility module containing arithmetic operations and string algorithms:

```python
def add(a: float, b: float) -> float:
    return a + b

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
```

### 3.2 Unit Test Suite: `Assignment 2/test_app.py`
A test suite covering standard cases, edge cases (division by zero, negative integers), and string manipulations:

```python
import unittest
from app import add, subtract, multiply, divide, reverse_string, is_palindrome

class TestAppOperations(unittest.TestCase):
    def test_addition(self):
        self.assertEqual(add(10, 5), 15)
        self.assertEqual(add(-1, 1), 0)

    def test_subtraction(self):
        self.assertEqual(subtract(10, 4), 6)

    def test_multiplication(self):
        self.assertEqual(multiply(3, 4), 12)

    def test_division(self):
        self.assertEqual(divide(20, 5), 4)

    def test_division_by_zero(self):
        with self.assertRaises(ValueError):
            divide(10, 0)

    def test_reverse_string(self):
        self.assertEqual(reverse_string("hello"), "olleh")

    def test_palindrome(self):
        self.assertTrue(is_palindrome("racecar"))
        self.assertTrue(is_palindrome("A man a plan a canal Panama"))
```

---

## 4. Intentional Failure vs. Correction Demonstration

To prove that the CI pipeline catches faults before deployment, a two-phase test was executed directly on GitHub Actions:

```
[Phase 1: Intentional Error] ────────> Push to main ────────> ❌ GitHub Actions FAILS (Run ID: 34226232874)
                                                                 (AssertionError: 25 != 15)

[Phase 2: Bug Correction]   ────────> Push to main ────────> ✅ GitHub Actions PASSES (Run ID: 34226382980)
                                                                 (7/7 Tests Passed Cleanly)
```

### Phase 1: Intentional Error Injection & Failure Observation
1. **Change Introduced:** In `Assignment 2/app.py`, modified the `add` function:
   ```python
   def add(a: float, b: float) -> float:
       return a + b + 10  # Intentional error to break unit tests
   ```
2. **Pushed to GitHub:** Commit [`bcf9ea3`](https://github.com/pratik4352/Devops-Lab-Assignment/commit/bcf9ea3)
3. **Workflow Result:**
   * **Run ID:** `34226232874`
   * **Status:** `completed`
   * **Conclusion:** `failure` ❌
   * **Run URL:** [https://github.com/pratik4352/Devops-Lab-Assignment/actions/runs/34226232874](https://github.com/pratik4352/Devops-Lab-Assignment/actions/runs/34226232874)
   * **Captured Error Log:**
     ```text
     FAIL: test_addition (test_app.TestAppOperations.test_addition)
     Traceback (most recent call last):
       File "Assignment 2/test_app.py", line 11, in test_addition
         self.assertEqual(add(10, 5), 15)
     AssertionError: 25 != 15
     FAILED (failures=1)
     ```

### Phase 2: Defect Correction & Successful Verification
1. **Correction Applied:** Restored `add(a, b)` to return `a + b`. Added `.gitignore` to prevent caching artifacts.
2. **Pushed to GitHub:** Commit [`2638df6`](https://github.com/pratik4352/Devops-Lab-Assignment/commit/2638df6)
3. **Workflow Result:**
   * **Run ID:** `34226382980`
   * **Status:** `completed`
   * **Conclusion:** `success` ✅
   * **Run URL:** [https://github.com/pratik4352/Devops-Lab-Assignment/actions/runs/34226382980](https://github.com/pratik4352/Devops-Lab-Assignment/actions/runs/34226382980)
   * **Captured Success Log:**
     ```text
     Assignment 2/test_app.py::TestAppOperations::test_addition PASSED
     Assignment 2/test_app.py::TestAppOperations::test_division PASSED
     Assignment 2/test_app.py::TestAppOperations::test_division_by_zero PASSED
     Assignment 2/test_app.py::TestAppOperations::test_multiplication PASSED
     Assignment 2/test_app.py::TestAppOperations::test_palindrome PASSED
     Assignment 2/test_app.py::TestAppOperations::test_reverse_string PASSED
     Assignment 2/test_app.py::TestAppOperations::test_subtraction PASSED
     ============================== 7 passed in 0.08s ==============================
     ```

---

## 5. Summary of Workflow Runs on GitHub

| Run ID | Commit | Event | Result | Description | Live GitHub Run Link |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`34226232874`** | `bcf9ea3` | `push` | ❌ **Failed** | Intentional failure test (`25 != 15`) | [View Run #1](https://github.com/pratik4352/Devops-Lab-Assignment/actions/runs/34226232874) |
| **`34226382980`** | `2638df6` | `push` | ✅ **Passed** | Fixed calculation; all 7 tests passed | [View Run #2](https://github.com/pratik4352/Devops-Lab-Assignment/actions/runs/34226382980) |

---

## 6. DevOps Best Practices for GitHub Actions CI

1. **Keep Workflows Modular & Readable:** Break large pipelines into focused jobs (`lint`, `test`, `build`, `deploy`).
2. **Dependency Caching:** Leverage caching mechanisms (e.g., `cache: 'pip'` in `setup-python`) to reduce runner execution time and bandwidth.
3. **Pin Action Versions:** Use specific major versions (e.g., `actions/checkout@v4`, `actions/setup-python@v5`) or full commit SHAs to protect against upstream breaking changes.
4. **Shift-Left Security:** Never hardcode passwords, personal tokens, or production API keys in YAML files. Use GitHub Encrypted Secrets (`${{ secrets.SECRET_NAME }}`) and environments.
5. **Fail Fast:** Run lightweight checks (such as syntax linters and fast unit tests) early in the pipeline before expensive integration builds.

---

## 7. Conclusion

Continuous Integration with GitHub Actions provides an automated, reliable safety net for software engineering teams. By validating code on every push and pull request, bugs are surfaced immediately when context is fresh. This automated feedback loop prevents defective code from reaching production, reinforces coding standards, and accelerates overall release velocity.
