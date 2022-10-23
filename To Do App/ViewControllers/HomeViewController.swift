import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private var topBarAddButton: UIBarButtonItem!
    private var tableView: UITableView!
    
    private var databaseDataSource = DatabaseDataSource()
    
    private var itemsList: [ToDoListItem]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseDataSource.getItems(completion: { items in
            itemsList = items
            
            DispatchQueue.main.async {
                self.buildTopBar()
                self.buildViews()
                self.styleViews()
                self.buildConstraints()
            }
        })
        
    }
    
    private func buildTopBar() {
        topBarAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = topBarAddButton
        
        navigationItem.title = "CoreData TO DO List"
    }
    
    private func buildViews() {
        tableView = UITableView()
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func styleViews() {
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 150
    }
    
    private func buildConstraints() {
        tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    @objc private func addTapped() {
        let alert = UIAlertController(title: "New TO DO Item", message: "Enter new task", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak alert] _ in
            
            guard let textFieldData = alert?.textFields?[0].text else {
                fatalError()
            }
        
            self.databaseDataSource.createItem(name: textFieldData, completion: { success in
                success ? self.refreshDataAndTable() : print("Error")
            })

        }))
        
        present(alert, animated: true)
    }
    
    private func refreshDataAndTable() {
        databaseDataSource.getItems(completion: { items in
            itemsList = items
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseIdentifier) as? ToDoTableViewCell else {
            fatalError()
        }
        cell.setCellData(toDoItem: itemsList[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
