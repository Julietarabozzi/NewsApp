import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class AuthViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User?
    @Published var errorMessage: String?
    @Published var users: [User] = []

    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?

    init() {
        setupAuthStateListener()
        observeUsers()
    }

    deinit {
        listenerRegistration?.remove()
    }

    func setupAuthStateListener() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.user = user
            }
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.user = authResult?.user
                    self?.saveUser(email: email, uid: authResult?.user.uid ?? "")
                    self?.errorMessage = nil
                }
            }
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.user = authResult?.user
                    self?.errorMessage = nil
                }
            }
        }
    }

    func signOut(navigation: NavigationManager) {
        do {
            try Auth.auth().signOut()
            clearCache()
            DispatchQueue.main.async {
                self.user = nil
                navigation.state = .login
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func clearCache() {
        URLCache.shared.removeAllCachedResponses()
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }

    private func saveUser(email: String, uid: String) {
        let user = ["email": email, "uid": uid]
        db.collection("users").document(uid).setData(user) { error in
            if let error = error {
                print("Error adding user: \(error)")
            }
        }
    }

    func observeUsers() {
        listenerRegistration = db.collection("users").addSnapshotListener { [weak self] querySnapshot, error in
            if let error = error {
                print("Error getting users: \(error)")
                return
            }
            self?.users = querySnapshot?.documents.compactMap { document -> User? in
                try? document.data(as: User.self)
            } ?? []
        }
    }
}

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var email: String
    var uid: String
}

