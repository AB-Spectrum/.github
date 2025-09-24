#!/bin/bash
# AB Spectrum Project Creation Script
# Usage: ./create-project.sh <project-name> <project-type>

set -e

PROJECT_NAME="$1"
PROJECT_TYPE="$2"
ORGREPO_PATH="$(cd "$(dirname "$0")/.." && pwd)"

if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_TYPE" ]; then
    echo "Usage: $0 <project-name> <project-type>"
    echo ""
    echo "Project Types:"
    echo "  data-analytics    - Data analysis and reporting projects"
    echo "  ml-model         - Machine learning model development"
    echo "  clinical-dashboard - Clinical dashboards and applications"
    echo "  research         - Research and analysis projects"
    echo "  infra           - Infrastructure and DevOps projects"
    exit 1
fi

echo "🚀 Creating AB Spectrum project: $PROJECT_NAME ($PROJECT_TYPE)"

# Create project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Initialize git
git init
echo "✓ Initialized git repository"

# Create basic .github structure
mkdir -p .github/{ISSUE_TEMPLATE,workflows}

# Copy core organization files
cp "$ORGREPO_PATH/ISSUE_TEMPLATE"/* .github/ISSUE_TEMPLATE/
cp "$ORGREPO_PATH/pull_request_template.md" .github/
echo "✓ Copied AB Spectrum issue and PR templates"

# Project-specific setup
case "$PROJECT_TYPE" in
    "data-analytics")
        echo "📊 Setting up data analytics project..."

        # Copy data pipeline workflow
        cp "$ORGREPO_PATH/workflows/data-pipeline.yml" .github/workflows/

        # Create project structure
        mkdir -p {data/{raw,processed,external},notebooks,src/{data,visualization},tests,docs,reports}

        # Create README
        cat > README.md << EOF
# $PROJECT_NAME

## Mission
Supporting AB Spectrum's mission of improving autism therapy outcomes through data-driven insights.

## Clinical Context
[Describe how this data analysis improves therapy delivery]

## Project Structure
\`\`\`
$PROJECT_NAME/
├── data/
│   ├── raw/           # Original, immutable data
│   ├── processed/     # Cleaned and transformed data
│   └── external/      # Third-party data sources
├── notebooks/         # Jupyter notebooks for exploration
├── src/
│   ├── data/         # Data processing scripts
│   └── visualization/ # Plotting and dashboard code
├── tests/            # Unit tests
├── docs/             # Documentation
└── reports/          # Generated reports and analysis
\`\`\`

## HIPAA Compliance Checklist
- [ ] All PHI properly anonymized
- [ ] Data encryption implemented
- [ ] Access controls configured
- [ ] Audit logging enabled

## Getting Started
1. Install dependencies: \`pip install -r requirements.txt\`
2. Run data quality checks: \`python src/data/validate.py\`
3. Generate initial report: \`python src/generate_report.py\`
EOF

        # Create requirements.txt
        cat > requirements.txt << EOF
# Data Processing
pandas>=1.5.0
numpy>=1.21.0
scipy>=1.9.0

# Data Quality
great-expectations>=0.15.0
pandera>=0.12.0

# Visualization
matplotlib>=3.5.0
seaborn>=0.11.0
plotly>=5.10.0

# Clinical Analysis
scikit-learn>=1.1.0
statsmodels>=0.13.0

# Development
pytest>=7.0.0
black>=22.0.0
flake8>=5.0.0
EOF
        ;;

    "ml-model")
        echo "🤖 Setting up ML model project..."

        # Copy ML workflow
        cp "$ORGREPO_PATH/workflows/ml-model-ci.yml" .github/workflows/

        # Create project structure
        mkdir -p {models,data/{raw,processed},notebooks,src/{preprocessing,training,evaluation,deployment},tests,docs,experiments}

        # Create README
        cat > README.md << EOF
# $PROJECT_NAME

## Mission
Developing ML models to support AB Spectrum's autism therapy optimization goals.

## Clinical Context
[Describe the therapeutic problem this model addresses]

## Model Overview
- **Problem Type**: [Classification/Regression/Clustering]
- **Target Variable**: [What the model predicts]
- **Clinical Application**: [How therapists will use predictions]
- **Success Metrics**: [Clinical effectiveness measures]

## Project Structure
\`\`\`
$PROJECT_NAME/
├── models/           # Trained model artifacts
├── data/
│   ├── raw/         # Original datasets
│   └── processed/   # Feature-engineered datasets
├── notebooks/       # Experimental notebooks
├── src/
│   ├── preprocessing/ # Data preparation
│   ├── training/    # Model training
│   ├── evaluation/  # Model assessment
│   └── deployment/  # Production deployment
├── experiments/     # Experiment tracking
└── tests/          # Model validation tests
\`\`\`

## Model Development Checklist
- [ ] Clinical validation completed
- [ ] Bias testing performed
- [ ] Performance meets threshold (>85% accuracy)
- [ ] Model interpretability documented
- [ ] A/B testing plan prepared

## Compliance Requirements
- [ ] Model explainability for clinical decisions
- [ ] Bias detection across demographics
- [ ] Clinical safety validation
- [ ] Regulatory documentation complete
EOF

        # Create requirements.txt
        cat > requirements.txt << EOF
# ML Core
tensorflow>=2.10.0
scikit-learn>=1.1.0
xgboost>=1.6.0
lightgbm>=3.3.0

# Data Processing
pandas>=1.5.0
numpy>=1.21.0

# Model Tracking
mlflow>=2.0.0
wandb>=0.13.0

# Model Validation
shap>=0.41.0
lime>=0.2.0
fairlearn>=0.8.0

# Clinical Validation
scipy>=1.9.0
statsmodels>=0.13.0

# Development
pytest>=7.0.0
black>=22.0.0
EOF
        ;;

    "clinical-dashboard")
        echo "🏥 Setting up clinical dashboard project..."

        # Create project structure
        mkdir -p {src/{components,pages,utils,services},public,tests,docs}

        # Create README
        cat > README.md << EOF
# $PROJECT_NAME

## Mission
Clinical dashboard supporting AB Spectrum therapists with real-time therapy insights.

## Clinical Context
[Describe how this dashboard improves clinical workflows]

## Features
- [ ] Real-time therapy session monitoring
- [ ] Progress visualization
- [ ] Alert system for intervention needs
- [ ] Family communication tools

## Project Structure
\`\`\`
$PROJECT_NAME/
├── src/
│   ├── components/   # Reusable UI components
│   ├── pages/       # Application pages
│   ├── utils/       # Helper functions
│   └── services/    # API and data services
├── public/          # Static assets
├── tests/           # Unit and integration tests
└── docs/           # User documentation
\`\`\`

## Clinical Safety Checklist
- [ ] PHI protection verified
- [ ] User access controls implemented
- [ ] Audit logging enabled
- [ ] Clinical workflow validation completed
- [ ] Accessibility standards met (WCAG 2.1 AA)

## HIPAA Compliance
- [ ] Data encryption in transit and at rest
- [ ] User authentication and authorization
- [ ] Session management security
- [ ] PHI access logging
EOF

        # Create package.json
        cat > package.json << EOF
{
  "name": "$PROJECT_NAME",
  "version": "1.0.0",
  "description": "AB Spectrum clinical dashboard",
  "main": "src/index.js",
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "test:a11y": "jest --config jest.a11y.config.js",
    "scan:phi": "node scripts/scan-phi.js"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.4.0"
  },
  "devDependencies": {
    "react-scripts": "^5.0.1",
    "@testing-library/react": "^13.4.0",
    "@testing-library/jest-dom": "^5.16.0"
  }
}
EOF
        ;;

    *)
        echo "❌ Unknown project type: $PROJECT_TYPE"
        exit 1
        ;;
esac

# Create standard files
cat > .gitignore << EOF
# Dependencies
node_modules/
venv/
env/
__pycache__/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Data (never commit real data)
data/raw/
data/external/
*.csv
*.xlsx
*.json
!data/sample/

# Models
models/*.pkl
models/*.h5
models/*.joblib
!models/README.md

# Secrets
.env
secrets/
*.key
*.pem

# Logs
*.log
logs/

# Build
build/
dist/
EOF

# Initial commit
git add .
git commit -m "$(cat << EOF
Initial AB Spectrum $PROJECT_TYPE project setup

Created $PROJECT_NAME with:
- AB Spectrum issue and PR templates
- Project-specific CI/CD workflows
- HIPAA-compliant project structure
- Clinical context documentation
- Development dependencies and tooling

Ready for AB Spectrum therapy outcome optimization development.
EOF
)"

echo ""
echo "✅ Project created successfully!"
echo ""
echo "📁 Project location: $(pwd)"
echo "📋 Next steps:"
echo "   1. cd $PROJECT_NAME"
echo "   2. Review and customize README.md"
echo "   3. Set up your development environment"
echo "   4. Create GitHub repository and push:"
echo "      git remote add origin https://github.com/AB-Spectrum/$PROJECT_NAME.git"
echo "      git push -u origin main"
echo ""
echo "🏥 Remember: This project follows AB Spectrum's clinical standards"
echo "   - Always maintain HIPAA compliance"
echo "   - Focus on therapy outcome improvement"
echo "   - Document clinical impact and safety considerations"