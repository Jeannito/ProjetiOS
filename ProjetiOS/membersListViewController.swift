//
//  membersListViewController.swift
//  ProjetiOS
//
//  Created by Bruté de Rémur Raphaël on 22/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

/*class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var messagesTable: UITableView!
    
    var message = Message.getAllMessage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: Any) {
        self.performSegue(withIdentifier: "deconnect", sender: self)
        Session.sharedInstance.setLogin(login: "nil")
        Session.sharedInstance.setStatus(status: "nil")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.messagesTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        
        
        
        cell.loginLabel.text = self.message[indexPath.row].sender
        cell.messageLabel.text = self.message[indexPath.row].text
        
        return cell
    }
    
    func refreshMsg(){
        self.message=Message.getAllMessage()
    }
    
    /*
     // MARK: - Navigationself.firstNames[indexPath.row]
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
*/
