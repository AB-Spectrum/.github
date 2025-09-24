# AB Spectrum Organization Repository - Deployment Guide

## Overview

This guide explains how to deploy the AB Spectrum organization repository and create new projects using these standardized resources.

## Method 1: GitHub Organization Deployment (Recommended)

### Prerequisites
- GitHub organization named `AB-Spectrum` (or your org name)
- Admin access to the organization
- Git configured with appropriate credentials

### Step-by-Step Deployment

#### 1. Create Organization Repository
```bash
# On GitHub.com:
# 1. Go to your organization: https://github.com/AB-Spectrum
# 2. Click "New repository"
# 3. Repository name: .github
# 4. Description: "AB Spectrum organization-wide resources"
# 5. Make it Public (organization profiles should be public)
# 6. Do NOT initialize with README (we have our own)
```

#### 2. Deploy Organization Resources
```bash
# Navigate to the orgrepo directory
cd /path/to/AB-Spectrum/orgrepo

# Set the correct remote (if not already set)
git remote set-url origin https://github.com/AB-Spectrum/.github.git
# OR if using SSH:
# git remote set-url origin git@github.com:AB-Spectrum/.github.git

# Push to GitHub
git push -u origin main
```

#### 3. Verify Deployment
After deployment, check:
- [ ] Organization profile appears at: https://github.com/AB-Spectrum
- [ ] Profile README shows AB Spectrum engineering content
- [ ] Issue templates available when creating issues in any org repository
- [ ] PR template appears when creating PRs in any org repository

---

## Method 2: Copy Resources to Individual Projects

If you prefer to copy resources to specific repositories:

### For New Projects
```bash
# Create new project repository
mkdir my-new-project
cd my-new-project
git init

# Copy organization resources
cp -r /path/to/AB-Spectrum/orgrepo/.github .
# Remove organization-specific files
rm -rf .github/profile/  # Organization profile not needed in individual repos
rm .github/README.md     # Use project-specific README

# Customize for your project
echo "# My New Project" > README.md
```

### For Existing Projects
```bash
# Navigate to existing project
cd /path/to/existing-project

# Copy specific templates you need
mkdir -p .github/ISSUE_TEMPLATE
cp /path/to/orgrepo/ISSUE_TEMPLATE/* .github/ISSUE_TEMPLATE/
cp /path/to/orgrepo/pull_request_template.md .github/
cp /path/to/orgrepo/workflows/* .github/workflows/ 2>/dev/null || mkdir -p .github/workflows

# Commit the new templates
git add .github/
git commit -m "Add AB Spectrum issue and PR templates"
```

---

## Method 3: Fork and Customize

For projects that need customized versions:

```bash
# Fork the organization repository
git clone https://github.com/AB-Spectrum/.github.git my-project-templates
cd my-project-templates

# Customize templates for specific project needs
# Edit files in ISSUE_TEMPLATE/, workflows/, etc.

# Use in your project
cp -r .github /path/to/your-project/
```

---

## Creating New Projects with AB Spectrum Standards

### 1. Data Analytics Project
```bash
# Create new repository
mkdir aba-analytics-project
cd aba-analytics-project
git init

# Set up AB Spectrum structure
mkdir -p {data,notebooks,src,tests,docs}
cp /path/to/orgrepo/workflows/data-pipeline.yml .github/workflows/
cp /path/to/orgrepo/ISSUE_TEMPLATE/* .github/ISSUE_TEMPLATE/

# Create project README with AB Spectrum branding
cat > README.md << 'EOF'
# ABA Analytics Project

## Mission
Supporting AB Spectrum's mission of improving autism therapy outcomes through data-driven insights.

## Clinical Context
[Describe how this project improves therapy delivery]

## HIPAA Compliance
- [ ] All PHI properly anonymized
- [ ] Data encryption implemented
- [ ] Access controls configured
EOF

git add .
git commit -m "Initial AB Spectrum compliant project setup"
```

### 2. ML Model Project
```bash
# Create ML project
mkdir aba-ml-model
cd aba-ml-model
git init

# Set up ML project structure
mkdir -p {models,data,notebooks,src/{preprocessing,training,evaluation},tests,docs}
cp /path/to/orgrepo/workflows/ml-model-ci.yml .github/workflows/
cp /path/to/orgrepo/ISSUE_TEMPLATE/* .github/ISSUE_TEMPLATE/

# Add ML-specific templates
cat > .github/ISSUE_TEMPLATE/model-performance.yml << 'EOF'
name: 📈 Model Performance Issue
description: Report model performance or accuracy issues
title: "[Model Performance]: "
labels: ["model-performance", "ml"]

body:
  - type: dropdown
    id: model
    attributes:
      label: Model Type
      options:
        - Behavior Prediction Model
        - Intervention Optimizer
        - Progress Tracker
        - Other

  - type: textarea
    id: performance-metrics
    attributes:
      label: Performance Metrics
      description: Current vs expected performance metrics
      placeholder: |
        Current: Accuracy 0.75, F1 0.68
        Expected: Accuracy 0.85, F1 0.80
EOF
```

### 3. Clinical Dashboard Project
```bash
# Create dashboard project
mkdir aba-clinical-dashboard
cd aba-clinical-dashboard
git init

# Dashboard-specific structure
mkdir -p {src/{components,pages,utils},public,tests,docs}
cp /path/to/orgrepo/.github .
rm -rf .github/profile/  # Not needed for individual projects

# Add dashboard-specific workflow
cat > .github/workflows/frontend-ci.yml << 'EOF'
name: Clinical Dashboard CI/CD

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-node@v3
      with:
        node-version: '18'
    - run: npm ci
    - run: npm run test
    - run: npm run build

  accessibility-check:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Run accessibility tests
      run: |
        npm ci
        npm run test:a11y

  hipaa-compliance-check:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Check for PHI exposure
      run: |
        # Add HIPAA compliance scanning
        npm run scan:phi
EOF
```

---

## Customizing for Your Organization

### 1. Update Organization Name
```bash
# Find and replace organization references
find . -type f -name "*.md" -o -name "*.yml" | xargs sed -i 's/AB-Spectrum/YOUR-ORG-NAME/g'
find . -type f -name "*.md" -o -name "*.yml" | xargs sed -i 's/AB Spectrum/Your Organization/g'
```

### 2. Customize Issue Labels
```bash
# Edit .github/ISSUE_TEMPLATE/*.yml files
# Update labels to match your organization's labeling system
```

### 3. Modify Workflows
```bash
# Edit .github/workflows/*.yml files
# Update CI/CD pipelines for your infrastructure
# Modify environment variables and secrets
```

### 4. Update Contact Information
```bash
# Edit SECURITY.md, CONTRIBUTING.md, profile/README.md
# Replace email addresses and contact information
```

---

## Project Templates by Use Case

### Healthcare Data Analytics
- Copy: `data-pipeline.yml`, all issue templates, `SECURITY.md`
- Focus: HIPAA compliance, data quality, clinical impact

### Machine Learning Models
- Copy: `ml-model-ci.yml`, model-specific issue templates
- Focus: Model validation, bias detection, clinical effectiveness

### Clinical Applications
- Copy: All templates with emphasis on user safety and accessibility
- Focus: Patient safety, therapeutic workflow integration

### Research Projects
- Copy: Basic templates with added research ethics considerations
- Focus: IRB compliance, data sharing, publication guidelines

---

## Maintenance and Updates

### Keeping Templates Current
```bash
# Periodically sync with organization repository
git remote add upstream https://github.com/AB-Spectrum/.github.git
git fetch upstream
git merge upstream/main
```

### Organization-Wide Updates
```bash
# Update all repositories in organization
# Use GitHub CLI or API to apply changes across repos
gh repo list AB-Spectrum --limit 100 --json name | jq -r '.[].name' | while read repo; do
  echo "Updating $repo"
  # Add update logic here
done
```

---

## Troubleshooting

### Common Issues

1. **Templates not appearing**
   - Ensure `.github` repository is public in organization
   - Check file names match GitHub requirements exactly
   - Verify YAML syntax in template files

2. **Organization profile not showing**
   - Profile README must be in `profile/README.md`
   - Repository must be named exactly `.github`
   - Organization repository must be public

3. **Workflows not running**
   - Check GitHub Actions permissions in organization settings
   - Verify workflow YAML syntax
   - Ensure required secrets are configured

### Getting Help

- Check GitHub documentation: https://docs.github.com/en/communities
- Review template syntax: https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests
- Contact AB Spectrum engineering team: engineering@abspectrum.org

---

## Security Considerations

- Never commit actual PHI or sensitive data to templates
- Use environment variables for sensitive configuration
- Regularly audit access permissions
- Keep security policies up to date with regulations

---

**Remember**: These templates are designed specifically for AB Spectrum's healthcare technology focus. Always ensure HIPAA compliance and clinical safety in all implementations.