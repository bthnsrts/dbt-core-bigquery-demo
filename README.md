# dbt BigQuery Project

This project demonstrates data modeling using dbt with BigQuery.

## Prerequisites
- Python 3.8+
- Google Cloud Platform account with BigQuery access
- GCP service account with appropriate permissions

## Setup Instructions

### 1. Clone the Repository
```bash
git clone <repository-url>
cd dbt_core_bq_project
```

### 2. Set Up Virtual Environment
```bash
# Create virtual environment
python -m venv .venv

# Activate virtual environment
# On Mac/Linux:
source .venv/bin/activate
# On Windows:
# .venv\Scripts\activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Configure BigQuery Connection
Create a `profiles.yml` file in the `~/.dbt/` directory:
```yaml
my_dbt_project:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: service-account
      keyfile: /path/to/dbt-demo-service-account-key.json
      project: your-gcp-project-id
      dataset: dbt_dev
      threads: 4
      timeout_seconds: 300
      location: US
      priority: interactive
```

### 5. Set Environment Variables
Set the following environment variables for your BigQuery connection:

```bash
# Set BigQuery dataset name
export BIGQUERY_DATASET=your_dataset_name (jaffle_shop in our example)

# Set path to your BigQuery service account keyfile
export BIGQUERY_KEYFILE=/path/to/your-keyfile.json
```

### 6. Generate Sample Data with JafGen
[JafGen](https://github.com/dbt-labs/jaffle-shop-generator) helps create sample data for the jaffle shop project:

```bash
# Create jaffle shop data
jafgen --output-path seeds/jaffle-data
```

### 7. Run dbt Commands
```bash
# Test connection
dbt debug

# Run dbt
dbt run

# Generate documentation
dbt docs generate
dbt docs serve
```

## Project Structure
```
.
├── analyses/         # Ad-hoc analyses
├── macros/          # Reusable SQL snippets
├── models/          # dbt models organized by area
├── seeds/           # CSV files for seed data
├── snapshots/       # Snapshot configurations
├── tests/           # Custom data tests
└── dbt_project.yml  # Main dbt project configuration
```

## Development Workflow
1. Create or modify models in the `models/` directory
2. Test your changes with `dbt run` or `dbt test`
3. Document your models with appropriate comments
4. Use version control to track changes

## Additional Resources
- [dbt Documentation](https://docs.getdbt.com/)
- [BigQuery Documentation](https://cloud.google.com/bigquery/docs)
