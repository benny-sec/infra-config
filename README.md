## basic environment set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/basic-infra-config.sh)"

## JDK 11.x set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-jdk.sh)"

## Postgres-sql set-up with user creation for Atlassian productline
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-postgres-for-atlassian.sh)"

## Atlassion Jira set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/jira/setup-jira.sh)"

## Atlassion Confluence set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/confluence/setup-confluence.sh)"

## Atlassion Bamboo set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-bamboo.sh)"

## Atlassion Bitbucket set-up
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/bitbucket/setup-bitbucket.sh)"

## Atlassian Jira Service Desk
bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/jira-service-desk/setup-jira-service-desk.sh)"
