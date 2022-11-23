-- SQL script to set up a new Snowflake account for tests and GitHub workflows
-- Replace replace <password> placeholder in CREATE USER statement with an actual password of your choice

USE ROLE ACCOUNTADMIN;

---

CREATE ROLE SNOWDDL_ADMIN;

GRANT ROLE SYSADMIN TO ROLE SNOWDDL_ADMIN;
GRANT ROLE SECURITYADMIN TO ROLE SNOWDDL_ADMIN;

CREATE USER SNOWDDL
PASSWORD = '<password>'
DEFAULT_ROLE = SNOWDDL_ADMIN;

GRANT ROLE SNOWDDL_ADMIN TO USER SNOWDDL;
GRANT ROLE SNOWDDL_ADMIN TO ROLE ACCOUNTADMIN;

---

CREATE ROLE SNOWDDL_ADMIN_TEST;

GRANT ROLE ACCOUNTADMIN TO ROLE SNOWDDL_ADMIN_TEST;

CREATE USER SNOWDDL_TEST
PASSWORD = '<password>>'
DEFAULT_ROLE = SNOWDDL_ADMIN_TEST;

GRANT ROLE SNOWDDL_ADMIN_TEST TO USER SNOWDDL_TEST;

---

CREATE WAREHOUSE SNOWDDL_WH
WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE;

GRANT USAGE, OPERATE ON WAREHOUSE SNOWDDL_WH TO ROLE SNOWDDL_ADMIN;

ALTER USER SNOWDDL SET DEFAULT_WAREHOUSE = SNOWDDL_WH;
ALTER USER SNOWDDL_TEST SET DEFAULT_WAREHOUSE = SNOWDDL_WH;

---

GRANT CREATE SHARE, IMPORT SHARE ON ACCOUNT TO ROLE SNOWDDL_ADMIN;
GRANT OVERRIDE SHARE RESTRICTIONS ON ACCOUNT TO ROLE SNOWDDL_ADMIN;

---

CREATE STORAGE INTEGRATION TEST_STORAGE_INTEGRATION
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = GCS
ENABLED = TRUE
STORAGE_ALLOWED_LOCATIONS = ('*');

GRANT USAGE ON INTEGRATION TEST_STORAGE_INTEGRATION TO ROLE SNOWDDL_ADMIN;

---

CREATE API INTEGRATION TEST_API_INTEGRATION
API_PROVIDER=aws_api_gateway
API_AWS_ROLE_ARN='arn:aws:iam::123456789012:role/my_cloud_account_role'
API_ALLOWED_PREFIXES=('https://xyz.execute-api.us-west-2.amazonaws.com/production')
ENABLED=TRUE;

GRANT USAGE ON INTEGRATION TEST_API_INTEGRATION TO ROLE SNOWDDL_ADMIN;

