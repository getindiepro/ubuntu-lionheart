FROM ubuntu:25.10

# Set up non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive
# Update, install ca-certificates, and then install your needed package (e.g., gnupg) all in one run
RUN apt update && apt install -y ca-certificates gnupg


