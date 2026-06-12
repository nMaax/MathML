# MathML: Mathematical and Statistical Learning Examples

This repository contains a collection of statistical scripts in R and Python, organized by topic. It is configured to use modern dependency management tools (**renv** for R and **uv** for Python) to ensure a clean, isolated environment that does not interfere with your base system installations.

## 📂 Directory Structure

*   **`Linear_Models/`**: Regression analysis, ANOVA, and case studies (e.g., fuel consumption/insulation).
*   **`Probability_Statistics/`**: Basic probability, multinomial simulations, and multivariate normal distributions.
*   **`Bayesian/`**: JAGS/BUGS examples for Bayesian modeling.
*   **`Data/`**: Centralized datasets used by the scripts.

---

## 🛠️ R Environment Setup (Arch Linux)

### 0. Install R and Build Dependencies
Ensure R and the necessary tools for compiling packages (like `mvtnorm` and `rjags`) are installed:
```bash
sudo pacman -S r gcc-fortran make jags
```

### 1. Install the `renv` Gatekeeper
If you haven't already, install the `renv` package once. If you don't have write access to system folders, R will ask to create a personal library—choose **Yes**.

```bash
R -e "install.packages('renv')"
```

### 2. Initialize and Install Dependencies
Run the following command in the project root to create the local `renv/` infrastructure and install all necessary packages for the scripts. This will **not** touch your system R library.

```bash
Rscript -e "renv::init(); renv::install(c('rmarkdown', 'knitr', 'tidyr', 'dplyr', 'ggplot2', 'R2jags'))"
```

### 3. Usage
Every time you open R in this folder, the `.Rprofile` will automatically activate the local environment. You will see a message:
`* Project '~/Work/MathML' loaded. [renv 1.1.8]`

### 4. Running Scripts
You can run any R script from the terminal. The `.Rprofile` ensures that the project-local dependencies are used:

```bash
Rscript Probability_Statistics/exercises_basic.r
```

Or, inside an R session:
```r
source("Linear_Models/execsal.r")
```

---

## 🐍 Python Environment Setup

We use **`uv`** for extremely fast, isolated Python management.

### 0. Install Python and uv
Ensure Python and the `uv` tool are installed on your Arch system:
```bash
sudo pacman -S python uv
```

### 1. Bootstrap the Environment
Simply run `uv lock` or `uv sync` to generate the virtual environment and lockfile based on `pyproject.toml`.

```bash
uv sync
```

### 2. Running Scripts
Execute your Python scripts through `uv` to ensure they use the isolated environment:

```bash
uv run Linear_Models/linear_models_insulate.py
```

---

## ⚠️ Important Notes

### Missing Data: RATS Example
The **`Bayesian/jags_classic_bugs.rmd`** script requires the "Classic BUGS" dataset which is not included in this repo. 
1. Download from: [Classic BUGS Examples](https://sourceforge.net/projects/mcmc-jags/files/Examples/4.x/classic-bugs.tar.gz/download)
2. Update the `setwd()` or file paths in the script to your local download location.

### Cleanliness
*   **Git**: Both `renv/` and Python virtual environments are ignored via `.gitignore` to keep the repository lean.
*   **Updates**: To add a new package in R, use `install.packages("pkg")` then `renv::snapshot()`. In Python, use `uv add <package>`.
