# PrivyDNS [![Python Test Suite](https://github.com/PrivyDNS/PrivyDNS/actions/workflows/python-tests.yml/badge.svg)](https://github.com/PrivyDNS/PrivyDNS/actions/workflows/python-tests.yml)

![Pytest](https://img.shields.io/badge/pytest-%23ffffff.svg?style=flat-square&logo=pytest&logoColor=2f9fe3)
![Python](https://img.shields.io/badge/python-3670A0?style=flat-square&logo=python&logoColor=ffdd54)
![Python Version](https://img.shields.io/badge/Python-3.12%2B-blue.svg?style=flat-square)
![PyPi](https://img.shields.io/badge/pypi-%23ececec.svg?style=flat-square&logo=pypi&logoColor=1f73b7)
![MIT License](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)

**PrivyDNS** is a Python library designed to securely query DNS records over encrypted protocols including DNS over HTTPS (DoH), DNS over TLS (DoT), and DNSCrypt. It supports both **synchronous** and **asynchronous** DNS queries with features such as **caching**, **retry mechanisms**, **logging**, and **encryption**. It provides developers with an easy-to-use interface to enhance DNS security, reliability, and performance.

## Features
- **Protocols Supported:**
	- DNS over HTTPS (DoH)
	- DNS over TLS (DoT)
	- DNSCrypt
- **Cache Support**: Caches DNS responses to improve performance.
- **Retry Mechanism**: Automatically retries failed DNS queries.
- **Logging**: Provides detailed logs for better debugging.
- **Async & Sync Support**: Supports both asynchronous and synchronous operations.

## Architecture

You can learn more about the architecture, protocols, and features of PrivyDNS in the [ARCHITECTURE.md](ARCHITECTURE.md) file.

## Background

For an in-depth explanation of DNS over HTTPS (DoH), DNS over TLS (DoT), and DNSCrypt, refer to the [BACKGROUND.md](BACKGROUND.md) file.

## Installation

```bash
pip install privydns
```

## Usage

### Synchronous DNS Query

```python
from privydns import DNSResolver

resolver = DNSResolver()

# DNS over HTTPS query
response = resolver.query("example.com", protocol="doh")
print(response)

# DNS over TLS query
response = resolver.query("example.com", protocol="dot")
print(response)
```

### Asynchronous DNS Query

```python
import asyncio
from privydns import DNSResolver

async def main():
    resolver = DNSResolver()
    response = await resolver.query("example.com", protocol="doh", async_mode=True)
    print(response)

asyncio.run(main())
```

### DNSCrypt Query

```python
from privydns import DNSCryptResolver

crypt_resolver = DNSCryptResolver()
response = crypt_resolver.query("example.com")
print(response)
```

## Testing

To run the tests, install the required packages and run the following command:

```bash
pip install -r requirements.txt
pytest .
```

### Running Tests in _Docker_ 🐳

This project includes a `Dockerfile` and `docker-compose.yml` file to run the tests inside a Docker container. It was build to mimic the [GitHub Actions](.github/workflows/python-tests.yml) workflow.

To build the Docker image, run the following command:

```bash
docker compose build
```

To run the tests inside the Docker container, execute the following command:

```bash
docker compose run
```

## Publishing to [PyPI](https://pypi.org)

To publish this project to PyPI, follow these steps:

1. **Install Required Tools**
   Ensure you have the latest versions of `setuptools`, `wheel`, and `twine` installed.

   ```bash
   pip install --upgrade setuptools wheel twine build
   ```

2. **Build the Distribution Files**
   Run the following command to build the source distribution (`.tar.gz`) and the wheel distribution (`.whl`).

   ```bash
   python -m build
   ```

   The distribution files will be available in the `dist` directory.

3. **Upload to Test PyPI (Optional)**
   Before uploading to the official PyPI, you can test the package on [Test PyPI](https://test.pypi.org):

   ```bash
   twine upload --repository testpypi dist/*
   ```

   You can verify your package at the Test PyPI URL (`https://test.pypi.org/project/your-package-name`).

4. **Upload to PyPI**
   If everything looks good, upload the package to the official PyPI repository:

   ```bash
   twine upload dist/*
   ```

   Make sure you have your PyPI credentials ready—refer to the PyPI website documentation if needed.

5. **Verify the Package**
   After publishing, verify that your package is listed on [PyPI](https://pypi.org). You can install it like any other package to confirm the installation is working:

   ```bash
   pip install privydns
   ```

6. **Important Notes**:
	- Ensure the `setup.py` file has all required metadata filled in (e.g., `name`, `version`, `author`, `description`, etc.).
	- Keep the version number updated for every new release.

## License

This project is licensed under the MIT License—see the [LICENSE](LICENSE) file for details.
