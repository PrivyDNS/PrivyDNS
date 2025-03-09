# Understanding DNS Over TLS (DoT), DNS Over HTTPS (DoH), and DNSCrypt

## Introduction

The Domain Name System (DNS) is a critical part of the internet infrastructure, translating human-readable domain names into machine-readable IP addresses. Traditionally, DNS queries are transmitted over unencrypted UDP or TCP protocols, making them vulnerable to eavesdropping, tampering, and man-in-the-middle attacks. To address these security concerns, newer protocols such as **DNS Over TLS (DoT)**, **DNS Over HTTPS (DoH)**, and **DNSCrypt** have been introduced. These protocols aim to encrypt DNS traffic, ensuring privacy, integrity, and security.

This document explains the purpose, functioning, and benefits of DoT, DoH, and DNSCrypt, with visual diagrams to illustrate how they work.

## What is DNS Over TLS (DoT)?

**DNS Over TLS (DoT)** is a protocol for encrypting DNS queries using **Transport Layer Security (TLS)**. DoT protects the privacy and integrity of DNS requests by establishing a secure TLS connection between the client and the DNS resolver. It uses the same port (53) as traditional DNS, but the traffic is encrypted, making it harder for third parties to spy on or alter the queries.

### How DoT Works

1. **Client Initiates Connection**: The client makes a request to the DNS server over TCP, using port 853, which is reserved for DoT.
2. **TLS Handshake**: The client and server perform a TLS handshake, establishing an encrypted communication channel.
3. **Encrypted DNS Query**: The client sends the DNS query through the encrypted TLS connection.
4. **DNS Resolution**: The resolver processes the query, encrypts the response, and sends it back to the client over the same TLS connection.

### Diagram: DNS Over TLS Workflow

```mermaid
sequenceDiagram
    participant Client
    participant DNS Resolver
    Client->>DNS Resolver: Initiates connection on port 853
    DNS Resolver->>Client: Responds with server certificate (TLS Handshake)
    Client->>DNS Resolver: Sends encrypted DNS query
    DNS Resolver->>Client: Sends encrypted DNS response
```

### Benefits of DoT

- **Encryption**: Protects the DNS query and response from being intercepted or altered.
- **Privacy**: Prevents third parties (e.g., ISPs) from tracking user browsing activity.
- **Integrity**: Ensures the DNS data has not been tampered with during transmission.

## What is DNS Over HTTPS (DoH)?

**DNS Over HTTPS (DoH)** is similar to DoT but encrypts DNS queries over **HTTPS** (HyperText Transfer Protocol Secure). DoH operates over the standard HTTPS port (443) and uses the same encryption as web traffic. This makes it harder to detect DNS traffic as it looks like regular HTTPS traffic, providing additional privacy benefits.

### How DoH Works

1. **Client Sends HTTPS Request**: The client sends a DNS query in an HTTPS request to the DoH server, using port 443.
2. **TLS Handshake**: Similar to DoT, the client and server establish an encrypted TLS connection.
3. **DNS Query**: The DNS query is encapsulated within the HTTPS request.
4. **DNS Response**: The server responds with the DNS resolution, encapsulated in an HTTPS response.

### Diagram: DNS Over HTTPS Workflow

```mermaid
sequenceDiagram
    participant Client
    participant DoH Server
    Client->>DoH Server: Sends DNS query over HTTPS (port 443)
    DoH Server->>Client: Performs TLS handshake
    Client->>DoH Server: Sends encrypted DNS query
    DoH Server->>Client: Sends encrypted DNS response
```

### Benefits of DoH

- **Enhanced Privacy**: As DNS queries are sent over HTTPS, they are harder to differentiate from other web traffic, providing better privacy protection.
- **Bypass Censorship**: DoH can bypass network-level filtering and censorship because it uses port 443, which is generally open in most networks.
- **Encryption and Integrity**: Just like DoT, DoH ensures that DNS traffic is encrypted and protected from tampering.

## What is DNSCrypt?

**DNSCrypt** is a protocol designed to secure DNS traffic between the client and the resolver using encryption. It supports both UDP and TCP transport methods. DNSCrypt encrypts DNS queries and responses, preventing third parties from observing or tampering with DNS traffic.

DNSCrypt allows DNS resolvers to authenticate the source of the DNS response, making sure the responses are from a legitimate source, not a malicious entity.

### How DNSCrypt Works

1. **Client Initiates Query**: The client sends a DNS query to the DNSCrypt resolver.
2. **Encrypt the Query**: DNSCrypt encrypts the DNS query using strong cryptographic algorithms.
3. **Send the Query**: The encrypted DNS query is sent over UDP or TCP to the resolver.
4. **Resolver Responds**: The resolver sends back an encrypted DNS response to the client.
5. **Decrypt the Response**: The client decrypts the response and receives the DNS result.

### Diagram: DNSCrypt Workflow

```mermaid
sequenceDiagram
    participant Client
    participant DNSCrypt Resolver
    Client->>DNSCrypt Resolver: Sends encrypted DNS query
    DNSCrypt Resolver->>Client: Sends encrypted DNS response
    Client->>DNSCrypt Resolver: Decrypts the response
```

### Benefits of DNSCrypt

- **Strong Encryption**: Provides encryption to protect against eavesdropping.
- **Authentication**: Ensures that the DNS response comes from a trusted and legitimate source.
- **Integrity**: Guarantees the DNS query and response have not been tampered with.

## Why Use DoT, DoH, or DNSCrypt?

### 1. **Enhanced Privacy**
All three protocols — DoT, DoH, and DNSCrypt — ensure that DNS queries are encrypted, preventing third parties from monitoring user activity. This protects user privacy by making it difficult for ISPs, hackers, or other entities to track websites visited by a user.

### 2. **Prevent DNS Spoofing and Man-in-the-Middle Attacks**
Since DNS queries and responses are encrypted, attackers cannot easily intercept or modify DNS traffic. This protects against attacks such as DNS spoofing, where malicious actors inject fraudulent DNS responses.

### 3. **Bypass Censorship**
DoH, in particular, is useful for bypassing DNS-level censorship and restrictions. Since it runs over HTTPS (port 443), it is difficult for network filters or firewalls to distinguish it from normal web traffic, making it harder to block.

### 4. **Improved Security**
DNSCrypt offers authentication, ensuring that the DNS response comes from a legitimate source. This prevents attackers from providing malicious DNS responses, such as redirecting users to phishing websites.

## Conclusion

DoT, DoH, and DNSCrypt all offer enhanced security, privacy, and integrity for DNS traffic, making them crucial components of a secure internet browsing experience. While DoT and DoH use encryption to protect DNS queries, DNSCrypt adds the layer of authentication, ensuring that responses are legitimate. By implementing these protocols, users and organizations can safeguard their browsing activity from eavesdropping and tampering, improving overall security and privacy online.

## Further Reading

- [DNS Over TLS (DoT) RFC 7858](https://datatracker.ietf.org/doc/rfc7858/)
- [DNS Over HTTPS (DoH) RFC 8484](https://datatracker.ietf.org/doc/rfc8484/)
- [DNSCrypt Website](https://dnscrypt.info/)
