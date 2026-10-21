# Prompting tips for bioinformatics

Good prompts give an AI coding assistant enough context to help with the task you actually have. Treat its answers as suggestions to check, not as authority.

## 1. Give context: your goal and what you know

Say what you are studying, what you have tried, and what tools or skills you already have. This helps the assistant choose the right level of explanation.

- **Weak:** “Help me analyze these reads.”
- **Stronger:** “I’m learning microbial genomics. I know basic Python but am new to the command line. I have paired-end FASTQ reads from one bacterial isolate and want to understand the steps before I run them. Explain the next step without assuming I know sequencing jargon.”

## 2. Be specific about the output

Name the format, scope, and constraints you want. For commands, ask what each part does; for code, specify inputs and expected outputs.

- **Weak:** “Write a FASTQ script.”
- **Stronger:** “Write a short Python script that reads a FASTQ file and reports the number of records and mean sequence length. Show the complete script,   explain each part, and state how to run it. Do not modify the input file.”

## 3. Ask for an explanation, not just an answer

Request reasoning you can learn from: definitions, why a step is needed, and what assumptions it makes.

- **Weak:** “What is a variant call?”
- **Stronger:** “Explain what variant calling does in bacterial genomics, why a reference genome is needed, and one limitation. Define unfamiliar terms and use a tiny example; don’t give me a command yet.”

## 4. Ask to be quizzed

Tell the assistant to ask one question at a time and wait for your answer. Ask for a hint before the solution so you can retrieve what you learned.

- **Weak:** “Quiz me on FASTQ.”
- **Stronger:** “Quiz me on the four lines in a FASTQ record, one question at a time. Wait for my answer, then give brief feedback and a hint if I’m stuck. Don’t reveal the answer before I try.”

## 5. Ask for a review of your code

Share the relevant code and a small example input or error. Say what the code should do and ask for prioritized, actionable feedback rather than a rewrite.

- **Weak:** “Is this code okay?”
- **Stronger:** “Review this Python function that counts FASTQ records. It should count one record per four lines and leave the file unchanged. Check correctness and edge cases first; point to specific lines, explain each issue, and suggest a minimal fix. Don’t rewrite the whole script.”

## 6. Catch mistakes and check claims

Ask where factual claims come from, especially claims about file formats, software behavior, and recommended parameters. Verify important claims against the cited source; ask for a documentation link or section when one is missing.

- **Weak:** “Is this aligner option right?”
- **Stronger:** “You said `--very-sensitive` is valid for this command. Which version of the tool and which documentation page or help entry supports that? Quote the relevant option description, and tell me if you’re uncertain.”

Check commands against the tool itself and its official documentation. Start with the tool’s help (for example, `tool --help` or the relevant subcommand’s help), compare the option names and required arguments, and check the installed version. Do not assume an option from a different version applies.

Test risky or unfamiliar commands on a tiny copy first. Use a few made-up or representative records, inspect the output, and only then consider a full dataset. Ask the assistant to provide a minimal test input and expected output.

- **Weak:** “Run this on all my reads.”
- **Stronger:** “Before using this command on my dataset, show a harmless test using a temporary FASTQ with two short records. Explain the expected output and how I can confirm the original file was not changed.”

## A reusable prompt pattern

“I’m [goal and experience]. I have [input/tool/version] and want [specific outcome]. Please give me [format and level of detail]. Explain [what I want to learn], state assumptions, and cite documentation for version-specific claims. First show how to test this safely on a tiny example. Don’t [constraint].”

## Practice

Write a prompt yourself for each task. Include context, a clear requested output, and a way to check the answer.

1. You have a small bacterial FASTA file and want to find out whether it contains more than one sequence, without changing the file.
2. You are learning what read quality scores mean and want the assistant to teach you, then quiz you one question at a time.
3. You wrote a Python function to count FASTQ records; you want a focused code review and a tiny test case before trying a large file.
