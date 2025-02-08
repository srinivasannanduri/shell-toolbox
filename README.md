# shell-toolbox

This repository contains utility scripts (bash).

a script that reads a file line by line and executes a command dynamically using each line as input

## Scripts Overview

| #  | Script Name               | Link                                        | Description | Usage | Example |
|----|---------------------------|---------------------------------------------|-------------|-------|---------|
| 1  | `run_command_per_line.sh` | [run_command_per_line.sh](run-command-per-line.sh) | Reads a file line by line and executes a specified command for each line, tracking progress. | `./run_command_per_line.sh <file_path> "<command_template>"` | `./run_command_per_line.sh resources/input.txt "echo {}"` |
