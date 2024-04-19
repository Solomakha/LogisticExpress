import Foundation

public protocol SGConstruction {
    func loadSubviews()

    func addContent()
    func styleContent()
    func configureContent()
    func updateContent(animated: Bool)

    func makeConstraints()
    func removeConstraints()
    func resetConstraints()
}

// MARK: - Default implementation
public extension SGConstruction {
    func loadSubviews() {
        addContent()
        styleContent()
        configureContent()
        makeConstraints()
        updateContent(animated: false)
    }

    func configureContent() { /* Default Implementation, override in subclass if needed */ }

    func styleContent() { /* Default Implementation, override in subclass if needed */ }

    func updateContent(animated: Bool) { /* Default Implementation, override in subclass if needed */ }

    func makeConstraints() { /* Default Implementation, override in subclass if needed */ }

    func removeConstraints() { /* Default Implementation, override in subclass if needed */ }

    func resetConstraints() {
        removeConstraints()
        makeConstraints()
    }
}

