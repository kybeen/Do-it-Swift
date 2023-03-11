//
//  TableViewController.swift
//  Table
//
//  Created by 김영빈 on 2023/03/10.
//

import UIKit

// 모든 클래스에서 이미지를 사용할 수 있도록 이미지 파일을 외부 변수로 선언
var items = ["책 구매", "철수와 약속", "스터디 준비하기"]
var itemsImageFile = ["cart.png", "clock.png", "pencil.png"]

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem // 완쪽 바 버튼으로 edit 버튼 추가
    }

    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData() // 테이블 뷰를 다시 불러옴
    }
    
    // MARK: - Table view data source

    // 테이블의 섹션 개수를 리턴
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // 행 개수 리턴
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    // 셀의 설절 내용을 적용
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    // 셀 내용 삭제 기능 추가
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // 'Delete'를 한글로 수정하기
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    

    
    // Override to support rearranging the table view.
    // 목록 순서 바꾸기 기능 추가
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items[(fromIndexPath as NSIndexPath).row] // 이동할 아이템의 위치를 변수에 저장
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row] // 이동할 아이템의 이미지를 변수에 저장
        items.remove(at: (fromIndexPath as NSIndexPath).row) // 이동할 아이템을 삭제
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row) // 이동할 아이템의 이미지를 삭제
        items.insert(itemToMove, at: (to as NSIndexPath).row) // 삭제된 아이템을 이동할 위치로 삽입
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row) // 삭제된 아이템의 이미지를 이동할 위치로 삽입
        /* 위의 remove와 insert 작업 시에 앞뒤 아이템들의 인덱스는 재정렬됨 */
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // 세그웨이를 이용하여 뷰를 이동하는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[(indexPath! as NSIndexPath).row])
        }
    }
    

}
