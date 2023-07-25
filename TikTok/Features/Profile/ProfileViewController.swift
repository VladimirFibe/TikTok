import UIKit

class ProfileViewController: BaseViewController {
    private let person: Person
    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileViewController {
    override func setupViews() {
        super.setupViews()
        title = person.username.uppercased()
    }
}
