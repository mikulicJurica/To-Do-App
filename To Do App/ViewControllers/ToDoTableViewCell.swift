import UIKit
import SnapKit

class ToDoTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: ToDoTableViewCell.self)
    
    private var cellView: UIView!
    private var toDoText: UILabel!
    
    private var cellItem: ToDoListItem!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildAndConfigCell()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildAndConfigCell() {
        cellView = UIView()
        cellView.backgroundColor = .systemBlue
        cellView.layer.cornerRadius = 20
        addSubview(cellView)
        
        toDoText = UILabel()
        cellView.addSubview(toDoText)
    }
    
    private func buildConstraints() {
        cellView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(10)
        })
        
        toDoText.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(20)
        })
    }
    
    func setCellData(toDoItem: ToDoListItem) {
        cellItem = toDoItem
        toDoText.text = cellItem.name
    }
    
}
