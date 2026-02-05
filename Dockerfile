# ============================================================
# 🐳 DOCKERFILE - Your Recipe for Building a Docker Image
# ============================================================
# 
# WHAT IS THIS FILE?
# -------------------
# Think of a Dockerfile like a recipe for a cake:
#   - It lists all ingredients (Python, libraries)
#   - It gives step-by-step instructions
#   - Anyone with this recipe can make the EXACT same cake
#
# Each line starting with a COMMAND (like FROM, WORKDIR, COPY)
# is a separate step. Docker runs them one by one.
# ============================================================

# STEP 1: Choose a Base Image
# ----------------------------
# FROM = "Start with this as our foundation"
# 
# python:3.10-slim means:
#   - python:3.10 = Python version 3.10 installed
#   - slim = smaller version (without extra tools we don't need)
# 
# It's like saying "I want to start with a computer that already has Python 3.10"
FROM python:3.10-slim

# STEP 2: Set the Working Directory
# ----------------------------------
# WORKDIR = "Create this folder and go inside it"
# 
# Everything we do after this will be inside /app folder
# It's like saying "cd /app" but also creates the folder if it doesn't exist
WORKDIR /app

# STEP 3: Copy requirements.txt First (Optimization Trick!)
# ----------------------------------------------------------
# COPY = "Copy files from your computer into the container"
# 
# Why copy requirements.txt separately?
# - Docker caches each step
# - If your code changes but requirements.txt doesn't, 
#   Docker won't reinstall all libraries (saves time!)
COPY requirements.txt .

# STEP 4: Install Python Libraries
# ---------------------------------
# RUN = "Execute this command"
# 
# pip install -r requirements.txt = Install all libraries listed in the file
# --no-cache-dir = Don't save download cache (keeps image smaller)
RUN pip install --no-cache-dir -r requirements.txt

# STEP 5: Copy ALL Project Files
# -------------------------------
# COPY . . means:
#   - First . = Everything from your project folder (on your PC)
#   - Second . = Into /app folder (inside container)
# 
# This copies: app.py, templates/, artifacts/, src/, etc.
COPY . .

# STEP 6: Tell Docker Which Port We'll Use
# -----------------------------------------
# EXPOSE = "This app will be accessible on port 5000"
# 
# Flask runs on port 5000 by default
# This is like saying "open door number 5000"
EXPOSE 5000

# STEP 7: The Command to Start Our App
# -------------------------------------
# CMD = "When someone runs this container, execute this command"
# 
# python app.py = Start our Flask application
# 
# This is what happens when you type: docker run <image-name>
CMD ["python", "app.py"]

# ============================================================
# 📝 SUMMARY OF WHAT THIS DOCKERFILE DOES:
# ============================================================
# 1. Starts with Python 3.10 installed
# 2. Creates /app folder
# 3. Installs all required libraries
# 4. Copies your project files
# 5. Opens port 5000
# 6. Runs your Flask app
# ============================================================
