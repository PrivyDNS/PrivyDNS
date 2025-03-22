# PrivyDNS Architecture

The **PrivyDNS** library provides a robust, secure DNS querying solution with support for DNS over HTTPS (DoH), DNS over TLS (DoT), mutual TLS (mTLS), and DNSCrypt. It incorporates features such as **caching**, **retry mechanisms**, and **logging** to improve performance and reliability.

## High-Level Architecture

```mermaid
graph LR
  A[Client] --> B[DNSResolver]
  B --> C{Protocol Handler}
  C --> D[DoHHandler]
  C --> E[DoTHandler]
  C --> F[MTLSHandler]
  C --> G[DNSCryptResolver]
  D --> H[DoH Server]
  E --> I[DoT Server]
  F --> J[mTLS Server]
  G --> K[DNSCrypt Server]
  B --> L[Cache]
  B --> M[Retry Mechanism]
  B --> N[Logging]
```

### Key Components
1. **Client**: Initiates DNS queries, providing a domain name and the desired protocol.
2. **DNSResolver**: The main class handling DNS queries. It maintains a registry of protocol handlers and delegates queries to the appropriate handler.
3. **Protocol Handlers**: Specialized classes implementing the `DNSProtocolHandler` abstract base class:
   - **DoHHandler**: Sends DNS queries over HTTPS (DoH) using `httpx` to communicate with the DoH server.
   - **DoTHandler**: Sends DNS queries over TLS (DoT) using `dns.query.tls` for secure communication with the DoT server.
   - **MTLSHandler**: Sends DNS queries over mutual TLS (mTLS) with client certificate authentication.
4. **DNSCryptResolver**: A separate resolver for DNSCrypt protocol that encrypts DNS queries using **NaCl**.
5. **Cache**: Stores DNS responses temporarily using a TTL-based cache to avoid re-querying the same domain repeatedly.
6. **Retry Mechanism**: Ensures that failed queries are retried a specified number of times before raising an error.
7. **Logging**: Provides detailed logs about query operations, errors, cache hits/misses, and retry attempts.

## API Overview

### `DNSResolver`
- **Purpose**: Resolves DNS queries using various secure protocols.
- **Methods**:
  - `query(domain, record_type, protocol)`: Resolves a DNS query asynchronously using the specified protocol.

### `DNSProtocolHandler` (Abstract Base Class)
- **Purpose**: Defines the interface for all DNS protocol handlers.
- **Methods**:
  - `query(domain, record_type, cache, retries)`: Abstract method implemented by concrete handlers.

### Protocol Handlers
- **DoHHandler**: Handles DNS over HTTPS queries.
- **DoTHandler**: Handles DNS over TLS queries.
- **MTLSHandler**: Handles DNS over mutual TLS queries.

### `DNSCryptResolver`
- **Purpose**: Resolves DNS queries using DNSCrypt.
- **Methods**:
  - `query(domain, record_type)`: Resolves a DNS query using DNSCrypt.

### **Error Handling**
- **DNSQueryError**: Custom exception class used to handle DNS-related errors such as query failures.

## Cache & Retry Mechanism

```mermaid
graph LR
  A[Query Request] --> B[Cache Check]
  B -->|Cache Hit| C[Return Cached Response]
  B -->|Cache Miss| D[Query DNS Server]
  D --> E[Store Response in Cache]
  D --> F[Return DNS Response]
  D -->|Failure| G[Retry Logic]
  G --> H[Retry Count Reached?]
  H -->|Yes| I[Raise DNSQueryError]
  H -->|No| D[Retry Query]
```

- **Cache**: Each protocol handler checks if the response is already cached using a protocol-specific cache key. If it is, the cached response is returned.
- **Retry**: If a DNS query fails, the protocol handler retries the query a specified number of times before raising a `DNSQueryError`.

---

## Sequence of Events (DoH Query Example)

```mermaid
sequenceDiagram
  participant Client
  participant DNSResolver
  participant DoHHandler
  participant Cache
  participant DoHServer

  Client->>DNSResolver: query("example.com", protocol="doh")
  DNSResolver->>DoHHandler: query("example.com", "A", cache, retries)
  DoHHandler->>Cache: Check cache for "doh:example.com:A"
  Cache-->>DoHHandler: Cache miss
  DoHHandler->>DoHServer: Send query over HTTPS
  DoHServer-->>DoHHandler: Return DNS response
  DoHHandler->>Cache: Store response in cache
  DoHHandler-->>DNSResolver: Return DNS response
  DNSResolver-->>Client: Return DNS response
```

## Conclusion

PrivyDNS is designed with **security**, **performance**, and **reliability** in mind. Its modular architecture with protocol-specific handlers allows for easy extension to support additional secure DNS protocols. The library supports encrypted DNS protocols, efficient caching, and automatic retries to ensure that DNS queries are resolved securely and quickly, with detailed logging for easier debugging.
