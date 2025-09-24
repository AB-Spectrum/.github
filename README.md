# AB Spectrum Organization Repository

This repository contains the GitHub organization-level resources for AB Spectrum's engineering organization.

## Purpose

This is a special GitHub organization repository that provides:
- Organization profile and branding
- Standardized issue and PR templates
- Code of conduct and contribution guidelines
- Security policies and procedures
- CI/CD workflow templates

## Structure

```
orgrepo/
├── profile/
│   └── README.md                 # Organization profile (shown on GitHub org page)
├── ISSUE_TEMPLATE/
│   ├── bug-report.yml           # Bug report template
│   ├── feature-request.yml      # Feature request template
│   └── data-quality-issue.yml   # Data quality issue template
├── workflows/
│   ├── data-pipeline.yml        # Data pipeline CI/CD template
│   └── ml-model-ci.yml          # ML model CI/CD template
├── CONTRIBUTING.md              # Contribution guidelines
├── CODE_OF_CONDUCT.md          # Code of conduct
├── SECURITY.md                 # Security policy
└── pull_request_template.md    # PR template
```

## Usage

To use this as a GitHub organization repository:

1. Create a repository named `.github` in your GitHub organization
2. Copy all contents from this `orgrepo` directory to the `.github` repository
3. The organization profile will automatically appear on your organization's main page
4. Templates will be available across all repositories in the organization

## AB Spectrum Focus

All templates and policies are specifically designed for:
- Healthcare technology development
- HIPAA compliance requirements
- Data analytics and ML workflows
- Clinical decision support systems
- Autism therapy outcome optimization

## Clinical Context

These resources reflect AB Spectrum's mission of improving therapy outcomes for children with autism through innovative, evidence-based technology solutions while maintaining the highest standards of data privacy and clinical ethics.