---
name: find-skills
description: "Helps users discover and install agent skills when they ask questions like 'how do I do X', 'find a skill for X', 'is there a skill that can...', or express interest in extending capabilities."
---

## Core Purpose

This skill enables discovery and installation from the open agent skills ecosystem, functioning as a package manager for specialized agent capabilities.

## Key CLI Commands

- `npx skills find [query]` — Interactive or keyword-based skill searching
- `npx skills add <package>` — Install skills from GitHub or other sources
- `npx skills check` — Check for available updates
- `npx skills update` — Update all installed skills

Skills are browsable at https://skills.sh/

## Implementation Process

**Step 1:** Identify the domain, specific task, and likelihood of existing solutions

**Step 2:** Check the skills.sh leaderboard for established options before searching

**Step 3:** Execute searches using relevant terminology

**Step 4:** Verify quality metrics including install counts (prefer 1K+), source reputation, and GitHub stars

**Step 5:** Present options with skill name, install count, source, command, and learn-more link

**Step 6:** Offer installation assistance using `npx skills add <owner/repo@skill> -g -y`

## When No Skills Exist

Acknowledge the absence, offer direct assistance, and suggest creating custom skills via `npx skills init`
