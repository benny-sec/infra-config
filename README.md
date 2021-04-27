## basic environment set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/basic-infra-config.sh)"

## JDK 11.x set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-jdk.sh)"

## Postgres-sql set-up with user creation for Atlassian productline
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-postgres-for-atlassian.sh)"

## Atlassian Jira set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/jira/setup-jira.sh)"

## Atlassian Jira Service Desk
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/jira-service-desk/setup-jira-service-desk.sh)"

## Atlassian Confluence set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/confluence/setup-confluence.sh)"

## Atlassian Bitbucket set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/bitbucket/setup-bitbucket.sh)"

## Atlassian Bamboo set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/bamboo/setup-bamboo.sh)"

## Atlassian Crucible set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/crucible/setup-crucible.sh)"

