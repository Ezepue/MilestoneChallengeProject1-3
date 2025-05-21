import UIKit

class ViewController: UITableViewController {
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // To load the images from disk
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasSuffix("3x.png") {
                // this is a picture to load!
                flags.append(item)
            }
        }
        print(flags)
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return flags.count
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
            cell.textLabel?.text = flags[indexPath.row].uppercased().replacingOccurrences(of: "@3X.PNG", with: "")
            cell.imageView?.image = UIImage(named: flags[indexPath.row])
            
            cell.imageView?.layer.borderWidth = 1
            cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
            return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                let index = indexPath.row
                vc.selectedImage = flags[index]
                navigationController?.pushViewController(vc, animated: true)
                vc.title = "FLAG OF \(flags[index].uppercased().replacingOccurrences(of: "@3X.PNG", with: ""))"
            }
        }
}
