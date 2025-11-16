# Initialize bench with frapper version 15
bench init --frappe-branch version-15 <project>_next_bench
cd <project>_next_bench

# Install the required apps
bench get-app erpnext --branch version-15
bench new-app <app_name>

# Clone the <project>_next app from the repository
# git clone 
# git clone <git repostiory link>

# Install the apps into the bench
bench new-site <project>.local
bench --site <project>.local add-to-hosts

# Set up the site with the apps
bench --site <project>.local install-app erpnext
bench --site <project>.local install-app <project>_next
# Uninstall the erpnext app if needed
bench --site <project>.local uninstall-app <project>_next --yes --force --no-backup
bench --site <project>.local uninstall-app webshop --yes --force --no-backup


# Check required configs for verification
bench --site <project>.local list-apps
bench --site <project>.local console
bench --site <project>.local mariadb

# Check if the site is running
bench build
bench --site <project>.local migrate
bench restart
bench use <project>.local

bench --site <project>.local reinstall --yes
# setup wizard word after this

# diagnostics commands
bench --site <project>.local clear-cache
bench --site <project>.local migrate
bench find .

# turn on developer mode to craete doctypes programmatically
bench set-config -g developer_mode true

# Create the necessary doctypes and roles
bench execute <project>_next.scripts.execute_script.create_roles
bench execute <project>_next.scripts.execute_script.create_mode_of_payment
bench execute <project>_next.scripts.execute_script.create_doctype

# razorpay integration
bench setup requirements

# sync JSON files and fixtures
bench --site <project>.local export-doc "DocType" "Student Applicant"
bench --site <project>.local export-fixtures --app <project>_next
