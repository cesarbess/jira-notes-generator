# Jira Notes Generator

Generates notes from the Jira tickets assigned to you in the given column of the .env file.

## Getting Started



### Prerequisites

```
ruby 2.3.7
```

### Installing

Clone the repository
```
ssh: git clone git@github.com:cesarbess/jira-notes-generator.git
https: https://github.com/cesarbess/jira-notes-generator.git
```

Generate a Jira token for your account here: https://id.atlassian.com/manage/api-tokens

Open the .env file and enter the info:

```
EMAIL_ADDRESS= the email you use to login on Jira 
TOKEN= generated jira token here
URL= your main jira domain here, like https://domain-name.atlassian.net
COLUMN= the name of the column you want to get the assigned tickets from, eg: 'ready to test'
```

For last run:

`ruby main.rb`

from the console and the tickets assigned to you in the given column will pe printed out following the format:

```
Ticket number | Ticket Description | (ticket-link)
```

Example:

```
JR-326 | Setup login screen (https://example.atlassian.net/browse/JR-326
JR-327 | Setup sign up screen (https://example.atlassian.net/browse/JR-327
```
