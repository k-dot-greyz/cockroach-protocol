#!/usr/bin/env python3
"""tasks_sync.py — Parse tasks.md and sync Epics/Tasks to GitHub Issues.

Idempotent: stores issue numbers as HTML comments in tasks.md.
Runs on: workflow_dispatch or push to tasks.md.
"""
import os
import re
from github import Github

REPO_NAME = os.environ["REPO"]
TOKEN = os.environ["GITHUB_TOKEN"]
TASKS_FILE = "tasks.md"

EPIC_RE = re.compile(r"^## (Epic \d+ .+)$", re.MULTILINE)
TASK_RE = re.compile(r"^- \[([ xX])\] (.+?)(?:\s*<!--\s*#(\d+)\s*-->)?$")
ISSUE_MARKER = "<!-- #{issue_number} -->"


def get_or_create_epic(repo, title):
    """Find existing epic issue by title or create a new one."""
    label_name = "epic"
    for issue in repo.get_issues(state="open", labels=[label_name]):
        if issue.title == title:
            return issue.number
    issue = repo.create_issue(title=title, labels=[label_name])
    print(f"Created epic: #{issue.number} {title}")
    return issue.number


def get_or_create_task(repo, title, epic_number):
    """Find existing task issue by title or create a new one."""
    label_name = "task"
    for issue in repo.get_issues(state="all", labels=[label_name]):
        if issue.title == title:
            return issue.number
    body = f"Parent Epic: #{epic_number}"
    issue = repo.create_issue(title=title, body=body, labels=[label_name])
    print(f"Created task: #{issue.number} {title}")
    return issue.number


def main():
    g = Github(TOKEN)
    repo = g.get_repo(REPO_NAME)

    with open(TASKS_FILE, "r") as f:
        content = f.read()

    lines = content.splitlines()
    updated_lines = []
    current_epic_number = None

    i = 0
    while i < len(lines):
        line = lines[i]
        epic_match = EPIC_RE.match(line)
        if epic_match:
            epic_title = epic_match.group(1)
            current_epic_number = get_or_create_epic(repo, epic_title)
            updated_lines.append(line)
            i += 1
            continue

        task_match = TASK_RE.match(line)
        if task_match and current_epic_number:
            status, task_title, existing_num = task_match.groups()
            if existing_num:
                updated_lines.append(line)
            else:
                issue_num = get_or_create_task(repo, task_title, current_epic_number)
                marker = ISSUE_MARKER.format(issue_number=issue_num)
                updated_lines.append(f"- [{status}] {task_title} {marker}")
            i += 1
            continue

        updated_lines.append(line)
        i += 1

    new_content = "\n".join(updated_lines)
    if new_content != content:
        with open(TASKS_FILE, "w") as f:
            f.write(new_content)
        print("tasks.md updated with issue markers.")
    else:
        print("tasks.md unchanged — all issues already tracked.")


if __name__ == "__main__":
    main()
