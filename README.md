# Hevo DBT Project

This project is designed to perform data transformations and analytics using dbt. It includes models for summarizing customer orders, payments, and lifetime value.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Setting Up Your Environment](#setting-up-your-environment)
3. [Creating the profiles.yml File](#creating-the-profilesyml-file)
4. [Profiles.yml Template](#profilesyml-template)
5. [Running dbt Commands](#running-dbt-commands)

## Prerequisites

Before you begin, ensure you have the following installed:

- [Python](https://www.python.org/downloads/) (version 3.7 or higher)
- [dbt](https://docs.getdbt.com/docs/installation) (install using pip: `pip install dbt-snowflake`)
- Access to a Snowflake account

## Setting Up Your Environment

1. Clone this repository to your local machine:

   ```bash
   git clone git@github.com-kk-shetty:kk-shetty/hevo_dbt.git
   ```

2. Navigate to the project directory:

   ```bash
   cd hevo_dbt
   ```

3. Create a virtual environment (optional but recommended):

   ```bash
   python -m venv dbt-env
   source dbt-env/bin/activate  # On Windows use: dbt-env\Scripts\activate
   ```

4. Install the required packages:

   ```bash
   pip install dbt-snowflake
   ```

## Creating the profiles.yml File

The `profiles.yml` file is required for dbt to connect to your Snowflake account. Follow these steps to create the file:

1. Navigate to the `~/.dbt/` directory (create it if it doesn’t exist):

   ```bash
   mkdir -p ~/.dbt
   ```

2. Create a file named `profiles.yml`:

   ```bash
   nano ~/.dbt/profiles.yml
   ```

3. Add the following configuration (replace placeholders with your actual credentials):

   ```yaml
   hevo_dbt:
     outputs:
       dev:
         account: "{{ env_var('DB_ACCOUNT') }}"
         database: "{{ env_var('DB_DATABASE') }}"
         password: "{{ env_var('DB_PASS') }}"
         role: "{{ env_var('DB_ROLE') }}"
         schema: "{{ env_var('DB_SCHEMA') }}"
         threads: 1
         type: snowflake
         user: "{{ env_var('DB_USER') }}"
         warehouse: "{{ env_var('DB_WAREHOUSE') }}"
     target: dev
   ```

## Profiles.yml Template

Here’s the template for your `profiles.yml` file:

```yaml
hevo_dbt:
  outputs:
    dev:
      account: "your_account"
      database: "your_database"
      password: "your_password"
      role: "your_role"
      schema: "your_schema"
      threads: 1
      type: snowflake
      user: "your_username"
      warehouse: "your_warehouse"
  target: dev
```

### Required Credentials

- `account`: Your Snowflake account identifier (e.g., `fe20406.central-india.azure`).
- `database`: The name of the Snowflake database (e.g., `HEVO`).
- `warehouse`: The name of the Snowflake warehouse (e.g., `HEVO_TAM`).
- `schema`: The schema to use (e.g., `PUBLIC`).
- `user`: Your Snowflake username (e.g., `DATA_ADMIN`).
- `password`: Your Snowflake password.
- `role`: The role to assume in Snowflake (e.g., `ADMIN`).

## Running dbt Commands

To execute dbt commands from anywhere, you need to set the `DBT_PROFILES_DIR` environment variable to the directory where your `profiles.yml` file is located. 

For example:

```bash
export DBT_PROFILES_DIR=~/.dbt
```

You can then run dbt commands such as:

- **Run your dbt models**:

  ```bash
  dbt run
  ```

- **Test your dbt models**:

  ```bash
  dbt test
  ```

- **Generate documentation**:

  ```bash
  dbt docs generate
  dbt docs serve
  ```

## Conclusion

This README provides a comprehensive guide on setting up and running the Hevo dbt project. For any questions or issues, please refer to the [dbt documentation](https://docs.getdbt.com/docs/introduction) or reach out for support.
