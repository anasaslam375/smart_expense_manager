# Part 8: Scalability & Security

## Offline Synchronization

### Sync Architecture

**Strategy**: Incremental bidirectional synchronization with conflict resolution

**Sync Flow**:

1. Detect network connectivity
2. Pull server changes since last sync
3. Push local changes to server
4. Resolve conflicts using rules
5. Update local database
6. Notify UI of changes

**Conflict Resolution Rules**:

- Server wins for: User profile, settings, categories
- Last-write-wins for: Expense metadata (timestamps)
- User wins for: Expense notes, tags
- Manual resolution for: Duplicate expenses

**Implementation**:

**Android**:

```kotlin
class SyncManager(
    private val localDataSource: ExpenseLocalDataSource,
    private val remoteDataSource: ExpenseRemoteDataSource
) {
    suspend fun sync() {
        val lastSyncTime = localDataSource.getLastSyncTime()
        
        // Pull changes from server
        val serverChanges = remoteDataSource.getChangesSince(lastSyncTime)
        
        // Push local changes
        val localChanges = localDataSource.getPendingChanges()
        val pushResult = remoteDataSource.pushChanges(localChanges)
        
        // Merge and resolve conflicts
        val merged = mergeChanges(serverChanges, pushResult)
        
        // Update local database
        localDataSource.updateAll(merged)
        
        // Update sync timestamp
        localDataSource.updateLastSyncTime(Instant.now())
    }
    
    private fun mergeChanges(
        server: List<Expense>,
        local: List<Expense>
    ): List<Expense> {
        // Conflict resolution logic
    }
}
```

**iOS**:

```swift
class SyncManager {
    func sync() async throws {
        let lastSyncTime = localDataSource.getLastSyncTime()
        
        // Pull changes from server
        let serverChanges = try await remoteDataSource.getChangesSince(lastSyncTime)
        
        // Push local changes
        let localChanges = localDataSource.getPendingChanges()
        let pushResult = try await remoteDataSource.pushChanges(localChanges)
        
        // Merge and resolve conflicts
        let merged = mergeChanges(serverChanges: serverChanges, localChanges: pushResult)
        
        // Update local database
        try localDataSource.updateAll(merged)
        
        // Update sync timestamp
        localDataSource.updateLastSyncTime(Date())
    }
    
    private func mergeChanges(server: [Expense], local: [Expense]) -> [Expense] {
        // Conflict resolution logic
    }
}
```

**Flutter**:

```dart
class SyncManager {
  final ExpenseLocalDataSource localDataSource;
  final ExpenseRemoteDataSource remoteDataSource;

  Future<void> sync() async {
    final lastSyncTime = await localDataSource.getLastSyncTime();
    
    // Pull changes from server
    final serverChanges = await remoteDataSource.getChangesSince(lastSyncTime);
    
    // Push local changes
    final localChanges = await localDataSource.getPendingChanges();
    final pushResult = await remoteDataSource.pushChanges(localChanges);
    
    // Merge and resolve conflicts
    final merged = mergeChanges(serverChanges: serverChanges, localChanges: pushResult);
    
    // Update local database
    await localDataSource.updateAll(merged);
    
    // Update sync timestamp
    await localDataSource.updateLastSyncTime(DateTime.now());
  }
  
  List<Expense> mergeChanges({required List<Expense> server, required List<Expense> local}) {
    // Conflict resolution logic
  }
}
```

**Optimizations**:

- Batch operations for efficiency
- Delta sync (only changed data)
- Compress data before transmission
- Background sync with WorkManager/BackgroundTasks
- Retry with exponential backoff

---

## Multiple Devices Per User

### Architecture

**Strategy**: Cloud-first with local caching

**Data Flow**:

1. User creates expense on Device A
2. Expense synced to server
3. Device B pulls changes on next sync
4. Conflict resolution if simultaneous edits

**Implementation**:

**Server-Side**:

- User-scoped data isolation
- Device identification
- Last-write-wins with timestamps
- Eventual consistency model

**Client-Side**:

- Device ID generation on first launch
- Sync on app foreground
- Push notifications for real-time updates
- Conflict UI for user resolution

**Data Model**:

```json
{
  "id": "expense-123",
  "userId": "user-456",
  "deviceId": "device-789",
  "data": { ... },
  "version": 3,
  "lastModified": "2024-01-01T00:00:00Z",
  "lastModifiedBy": "device-789"
}
```

---

## Large Receipt Image Uploads

### Strategy

**Approach**: Chunked upload with compression

**Process**:

1. Capture or select image
2. Compress image (quality: 80%, max dimension: 2048px)
3. Generate image hash for deduplication
4. Upload in chunks (5MB each)
5. Verify upload integrity
6. Update expense with image URL

**Implementation**:

**Android**:

```kotlin
class ImageUploader(
    private val api: ImageUploadApi
) {
    suspend fun uploadImage(file: File): String {
        // Compress
        val compressed = compressImage(file)
        
        // Generate hash
        val hash = generateHash(compressed)
        
        // Check if already uploaded
        val existingUrl = api.checkImageExists(hash)
        if (existingUrl != null) return existingUrl
        
        // Upload in chunks
        val chunks = splitIntoChunks(compressed, 5 * 1024 * 1024)
        val uploadId = api.initiateUpload(hash, chunks.size)
        
        chunks.forEachIndexed { index, chunk ->
            api.uploadChunk(uploadId, index, chunk)
        }
        
        // Complete upload
        return api.completeUpload(uploadId)
    }
}
```

**iOS**:

```swift
class ImageUploader {
    func uploadImage(file: URL) async throws -> String {
        // Compress
        let compressed = try compressImage(file)
        
        // Generate hash
        let hash = try generateHash(compressed)
        
        // Check if already uploaded
        if let existingUrl = try await api.checkImageExists(hash) {
            return existingUrl
        }
        
        // Upload in chunks
        let chunks = splitIntoChunks(compressed, chunkSize: 5_000_000)
        let uploadId = try await api.initiateUpload(hash: hash, chunkCount: chunks.count)
        
        for (index, chunk) in chunks.enumerated() {
            try await api.uploadChunk(uploadId: uploadId, index: index, data: chunk)
        }
        
        // Complete upload
        return try await api.completeUpload(uploadId: uploadId)
    }
}
```

**Flutter**:

```dart
class ImageUploader {
  final ImageUploadApi api;

  Future<String> uploadImage(File file) async {
    // Compress
    final compressed = await compressImage(file);
    
    // Generate hash
    final hash = await generateHash(compressed);
    
    // Check if already uploaded
    final existingUrl = await api.checkImageExists(hash);
    if (existingUrl != null) return existingUrl;
    
    // Upload in chunks
    final chunks = splitIntoChunks(compressed, 5 * 1024 * 1024);
    final uploadId = await api.initiateUpload(hash, chunks.length);
    
    for (var i = 0; i < chunks.length; i++) {
      await api.uploadChunk(uploadId, i, chunks[i]);
    }
    
    // Complete upload
    return await api.completeUpload(uploadId);
  }
}
```

**Storage**:

- AWS S3 with lifecycle policies
- CDN for image delivery
- Image optimization on delivery
- Automatic cleanup of unused images

---

## Data Encryption

### Encryption Strategy

**At Rest**:

- Database encryption (SQLCipher for Android, Data Protection for iOS, Hive encryption for Flutter)
- Keychain/Keystore for sensitive keys
- File-level encryption for cached data

**In Transit**:

- TLS 1.3 for all network communication
- Certificate pinning
- Encrypted WebSocket connections

**Implementation**:

**Android**:

```kotlin
// Keychain/Keystore
class SecureStorage(context: Context) {
    private val keyStore = KeyStore.getInstance("AndroidKeyStore").apply {
        load(null)
    }
    
    fun store(key: String, value: String) {
        val cipher = Cipher.getInstance(TRANSFORMATION)
        cipher.init(Cipher.ENCRYPT_MODE, getSecretKey())
        val encrypted = cipher.doFinal(value.toByteArray())
        
        val sharedPreferences = context.getSharedPreferences("secure", Context.MODE_PRIVATE)
        sharedPreferences.edit()
            .putString(key, Base64.encodeToString(encrypted, Base64.DEFAULT))
            .apply()
    }
}
```

**iOS**:

```swift
// Keychain
class SecureStorage {
    func store(key: String, value: String) throws {
        let data = value.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unableToStore }
    }
}
```

**Flutter**:

```dart
// flutter_secure_storage
class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> store(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
```

**Sensitive Data**:

- Authentication tokens
- User credentials (temporary)
- Financial data
- Personal information
- API keys

---

## Secure Authentication

### Authentication Flow

**Strategy**: OAuth 2.0 with JWT tokens

**Flow**:

1. User enters credentials
2. Client sends to auth server
3. Server validates and returns JWT
4. Client stores token securely
5. Client includes token in API calls
6. Server validates token on each request
7. Token refresh before expiration

**Implementation**:

**Token Storage**:

- Android: EncryptedSharedPreferences
- iOS: Keychain
- Flutter: flutter_secure_storage
- Never store in plain text or UserDefaults

**Token Refresh**:

```kotlin
class AuthInterceptor(
    private val tokenProvider: TokenProvider
) : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request().newBuilder()
            .addHeader("Authorization", "Bearer ${tokenProvider.getAccessToken()}")
            .build()
            
        val response = chain.proceed(request)
        
        if (response.code == 401) {
            // Refresh token
            val newToken = tokenProvider.refreshToken()
            return chain.proceed(
                request.newBuilder()
                    .addHeader("Authorization", "Bearer $newToken")
                    .build()
            )
        }
        
        return response
    }
}
```

**iOS**:

```swift
class AuthInterceptor: Interceptor {
    func intercept(_ chain: Interceptor.Chain) async throws -> Response {
        var request = chain.request
        request.addValue("Bearer \(tokenProvider.getAccessToken())", forHTTPHeaderField: "Authorization")
        
        let response = try await chain.proceed(request)
        
        if response.statusCode == 401 {
            let newToken = try await tokenProvider.refreshToken()
            var newRequest = chain.request
            newRequest.addValue("Bearer \(newToken)", forHTTPHeaderField: "Authorization")
            return try await chain.proceed(newRequest)
        }
        
        return response
    }
}
```

**Flutter**:

```dart
class AuthInterceptor extends Interceptor {
  final TokenProvider tokenProvider;

  AuthInterceptor(this.tokenProvider);

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenProvider.getAccessToken();
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final newToken = await tokenProvider.refreshToken();
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';
        final response = await Dio().fetch(options);
        handler.resolve(response);
        return;
      } catch (e) {
        handler.next(err);
        return;
      }
    }
    handler.next(err);
  }
}
```

**Biometric Authentication**:

- Face ID / Touch ID for quick access
- Fingerprint authentication on Android
- Fallback to PIN/pattern
- Secure enclave for biometric data

---

## API Versioning

### Versioning Strategy

**Approach**: URL-based versioning

**Pattern**: `/api/v1/expenses`

**Versioning Rules**:

- Major version changes for breaking changes
- Minor version for additions
- Patch version for bug fixes
- Support at least 2 previous versions

**Implementation**:

**API Response**:

```json
{
  "data": { ... },
  "meta": {
    "version": "1.2.3",
    "apiVersion": "v1"
  }
}
```

**Deprecation**:

- Announce deprecation 3 months in advance
- Add deprecation headers to responses
- Sunset date in API documentation
- Monitor usage of old versions

---

## GDPR/Privacy Compliance

### Data Protection

**Principles**:

- Data minimization (collect only necessary data)
- Purpose limitation (use data only for stated purposes)
- Storage limitation (retain data only as long as needed)
- Accuracy (keep data accurate and up to date)
- Security (protect data appropriately)

**Implementation**:

**User Rights**:

- Right to access: Export all user data
- Right to rectification: Correct inaccurate data
- Right to erasure: Delete all user data
- Right to portability: Export in machine-readable format
- Right to object: Opt out of data processing

**Data Deletion**:

```kotlin
class UserDataDeleter(
    private val database: Database,
    private val storage: Storage
) {
    suspend fun deleteAllUserData(userId: String) {
        // Delete from database
        database.deleteUserExpenses(userId)
        database.deleteUserCategories(userId)
        database.deleteUserProfile(userId)
        
        // Delete from storage
        storage.deleteUserImages(userId)
        storage.deleteUserBackups(userId)
        
        // Delete from analytics (anonymize)
        analytics.anonymizeUser(userId)
        
        // Log deletion for compliance
        auditLog.logDataDeletion(userId)
    }
}
```

**Consent Management**:

- Clear consent dialogs
- Granular consent options
- Easy consent withdrawal
- Consent history tracking

**Privacy by Design**:

- Privacy impact assessments
- Data protection by default
- Regular privacy audits
- Privacy training for team

---

## Multi-Language Support

### Localization Strategy

**Approach**: Resource file-based localization

**Implementation**:

**Android**:

```xml
<!-- res/values/strings.xml -->
<resources>
    <string name="expense_amount">Expense Amount</string>
    <string name="add_expense">Add Expense</string>
</resources>

<!-- res/values-es/strings.xml -->
<resources>
    <string name="expense_amount">Monto del Gasto</string>
    <string name="add_expense">Agregar Gasto</string>
</resources>
```

**iOS**:

```swift
// Localizable.strings (English)
"expense_amount" = "Expense Amount";
"add_expense" = "Add Expense";

// Localizable.strings (Spanish)
"expense_amount" = "Monto del Gasto";
"add_expense" = "Agregar Gasto";
```

**Flutter**:

```dart
// lib/l10n/app_en.arb
{
  "@locale": "en",
  "expense_amount": "Expense Amount",
  "add_expense": "Add Expense",
}

// lib/l10n/app_es.arb
{
  "@locale": "es",
  "expense_amount": "Monto del Gasto",
  "add_expense": "Agregar Gasto",
}

// Usage in code
text: AppLocalizations.of(context)!.expenseAmount
```

**Supported Languages**:

- English (en)
- Spanish (es)
- French (fr)
- German (de)
- Japanese (ja)

**Localization Process**:

- Externalize all user-facing strings
- Use ICU message format for plurals
- Format dates and numbers locally
- Test with RTL languages
- Professional translation for production

---

## Multi-Currency Support

### Currency Strategy

**Approach**: Base currency with conversion

**Implementation**:

**Data Model**:

```json
{
  "id": "expense-123",
  "amount": 100.00,
  "currency": "USD",
  "baseAmount": 100.00,
  "baseCurrency": "USD",
  "exchangeRate": 1.0,
  "exchangeDate": "2024-01-01"
}
```

**Currency Conversion**:

```kotlin
class CurrencyConverter(
    private val api: ExchangeRateApi
) {
    suspend fun convert(
        amount: BigDecimal,
        from: Currency,
        to: Currency
    ): BigDecimal {
        if (from == to) return amount
        
        val rate = api.getExchangeRate(from, to)
        return amount * rate
    }
    
    suspend fun getExchangeRates(): Map<CurrencyPair, BigDecimal> {
        return api.getAllExchangeRates()
    }
}
```

**Display**:

- Format currency according to locale
- Show original currency if different from base
- Option to view in selected currency
- Historical exchange rates for old expenses

**Supported Currencies**:

- USD - US Dollar
- EUR - Euro
- GBP - British Pound
- JPY - Japanese Yen
- CAD - Canadian Dollar
- AUD - Australian Dollar
- INR - Indian Rupee
- CNY - Chinese Yuan

---

## Security Best Practices

### Network Security

- Certificate pinning
- TLS 1.3 minimum
- No HTTP allowed
- API key protection
- Request signing for sensitive operations

### Data Security

- Encrypt sensitive data at rest
- Secure key storage
- No hardcoded secrets
- Secure random number generation
- Memory cleanup for sensitive data

### Application Security

- Code obfuscation (ProGuard/R8 for Android, bitcode for iOS, flutter_oss_licensing for Flutter)
- Root/jailbreak detection
- Tamper detection
- Runtime application self-protection (RASP)
- Secure inter-process communication

### Third-Party Security

- Regular dependency updates
- Vulnerability scanning
- Minimal third-party dependencies
- Review third-party code
- Monitor for security advisories
