//
//  FullEyedropListTableViewController.swift
//  eyeRx
//
//  Created by ET USER on 6/17/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit

class FullEyedropListTableViewController: UITableViewController, UISearchBarDelegate {

    static let dropList = [["AK Poly Bac ointment", "gray_eyedrop"], ["Acetazolamide (pill)", "white_eyedrop"], ["Acular", "gray_eyedrop"], ["Acular LS", "gray_eyedrop"], ["Acuvail", "white_eyedrop"], ["Alamast", "white_eyedrop"], ["Alaway", "white_eyedrop"], ["Alcaftadine", "white_eyedrop"], ["Alocril", "white_eyedrop"], ["Alomide", "white_eyedrop"], ["Alphagan P", "purple_eyedrop"], ["Alrex", "pink_eyedrop"], ["Apraclonidine", "purple_eyedrop"], ["Artificial Tears", "white_eyedrop"], ["Artificial Tears (Preservative Free)", "white_eyedrop"], ["Atropine", "red_eyedrop"], ["Avenova Lid Scrub", "white_eyedrop"], ["Azasite", "white_eyedrop"], ["Azelastine", "white_eyedrop"], ["Azithromycin", "white_eyedrop"], ["Azopt", "orange_eyedrop"], ["Bacitracin Neom. Polym. Hydrocort. ointment", "gray_eyedrop"], ["Bacitracin Neomycin Polumyxin ointment", "gray_eyedrop"], ["Bacitracin Polymyxin ointment", "gray_eyedrop"], ["Bacitracin ointment", "gray_eyedrop"], ["Bausch and Lomb Tears", "white_eyedrop"], ["Bepotastine", "white_eyedrop"], ["Bepreve", "white_eyedrop"], ["Besifloxacin", "tan_eyedrop"], ["Besivance", "tan_eyedrop"], ["Betagan", "yellow_eyedrop"], ["Betaxolol", "blue_eyedrop"], ["Betimol", "yellow_eyedrop"], ["Betoptic S", "blue_eyedrop"], ["Bimatoprost", "turquoise_eyedrop"], ["Bion Tears", "white_eyedrop"], ["Bleph 10", "white_eyedrop"], ["Blephamide", "white_eyedrop"], ["Blephamide ointment", "gray_eyedrop"], ["Blink Tears", "turquoise_eyedrop"], ["Brimonidine", "purple_eyedrop"], ["Brimonidine/Timolol", "blue_eyedrop"], ["Brinzolamide", "orange_eyedrop"], ["Brinzolamide/Brimonidine", "turquoise_eyedrop"], ["BromSite", "white_eyedrop"], ["Bromfenac", "gray_eyedrop"], ["Carteolol", "yellow_eyedrop"], ["Cenegermin-bkbj", "white_eyedrop"], ["Cequa", "white_eyedrop"], ["Ciloxan", "tan_eyedrop"], ["Ciprofloxacin", "tan_eyedrop"], ["Cliradex Lid Scrub", "white_eyedrop"], ["Combigan", "blue_eyedrop"], ["Cosopt", "blue_eyedrop"], ["Crolom", "white_eyedrop"], ["Cromolyn", "white_eyedrop"], ["Cyclogyl", "red_eyedrop"], ["Cyclopentolate", "red_eyedrop"], ["Cyclosporine", "white_eyedrop"], ["Dexamethasone (shake well)", "white_eyedrop"], ["Diamox PILL", "white_eyedrop"], ["Diclofenac", "gray_eyedrop"], ["Difluprednate", "pink_eyedrop"], ["Dorzolamide", "orange_eyedrop"], ["Dorzolamide/Timolol", "blue_eyedrop"], ["Durezol", "pink_eyedrop"], ["Elestat", "white_eyedrop"], ["Emadine", "white_eyedrop"], ["Emedastine", "white_eyedrop"], ["Epinastine", "white_eyedrop"], ["Erythromycin ointment", "gray_eyedrop"], ["Erythromycin ointment", "white_eyedrop"], ["Eyelid Compresses", "white_eyedrop"], ["Eyelid Scrubs", "white_eyedrop"], ["FML (shake well)", "white_eyedrop"], ["FML Forte (shake well)", "white_eyedrop"], ["FML ointment", "gray_eyedrop"], ["Flarex (shake well)", "pink_eyedrop"], ["Fluorometholone (shake well)", "white_eyedrop"], ["Fluorometholone ointment", "gray_eyedrop"], ["Flurbiprofen", "gray_eyedrop"], ["Ganciclovir", "white_eyedrop"], ["Garamycin", "white_eyedrop"], ["Gatifloxacin", "tan_eyedrop"], ["GenTeal PM ointment", "white_eyedrop"], ["GenTeal Tears", "white_eyedrop"], ["Gentamycin", "white_eyedrop"], ["Gentamycin/Prednisolone", "white_eyedrop"], ["Gentamycin/Prednisolone ointment", "gray_eyedrop"], ["Homatropine", "red_eyedrop"], ["Ice Packs", "white_eyedrop"], ["Ilevro", "gray_eyedrop"], ["Ilotycin ointment", "gray_eyedrop"], ["Inveltys", "pink_eyedrop"], ["Iopidine", "white_eyedrop"], ["Iquix", "tan_eyedrop"], ["Isopto Carpine", "turquoise_eyedrop"], ["Istalol", "yellow_eyedrop"], ["Ketorolac", "gray_eyedrop"], ["Ketotifen", "white_eyedrop"], ["Lastacraft", "white_eyedrop"], ["Latanoprost", "blue_eyedrop"], ["Latanoprostene bunod", "blue_eyedrop"], ["Levobunolol", "yellow_eyedrop"], ["Levofloxacin", "tan_eyedrop"], ["Lid Compresses", "white_eyedrop"], ["Lid Scrubs", "white_eyedrop"], ["Lifitegrast", "white_eyedrop"], ["Lodoxamide", "white_eyedrop"], ["Lotemax (shake well)", "pink_eyedrop"], ["Lotemax gel", "pink_eyedrop"], ["Lotemax ointment", "pink_eyedrop"], ["Loteprednol (shake well)", "pink_eyedrop"], ["Loteprednol gel", "pink_eyedrop"], ["Loteprednol gel", "pink_eyedrop"], ["Loteprednol ointment", "pink_eyedrop"], ["Loteprednol/Tobramycin", "white_eyedrop"], ["Lumigan", "turquoise_eyedrop"], ["Maxidex (shake well)", "pink_eyedrop"], ["Maxitrol", "white_eyedrop"], ["Maxitrol ointment", "gray_eyedrop"], ["Methazolamide PILL", "white_eyedrop"], ["Metipranolol", "yellow_eyedrop"], ["Moxeza", "tan_eyedrop"], ["Moxifloxacin", "tan_eyedrop"], ["Muro 128", "white_eyedrop"], ["Muro 128 Ointment", "gray_eyedrop"], ["Natacyn", "gray_eyedrop"], ["Natamycin", "gray_eyedrop"], ["Nedocromil", "white_eyedrop"], ["Neo Polycin HC ointment", "gray_eyedrop"], ["Neo Polycin ointment", "gray_eyedrop"], ["Neomycin Polym. Dexamethasone ointment", "gray_eyedrop"], ["Neomycin Polymyxin Dexamethasone", "white_eyedrop"], ["Neomycin Polymyxin Gramicidin", "white_eyedrop"], ["Neomycin Polymyxin Hydrocortisone", "white_eyedrop"], ["Nepafenac", "gray_eyedrop"], ["Neptazine PILL", "gray_eyedrop"], ["Netarsudil", "white_eyedrop"], ["Netarsudil/Latanoprost", "white_eyedrop"], ["Nevanac", "gray_eyedrop"], ["Ocuflox", "tan_eyedrop"], ["Ocusoft Lid Scrub", "white_eyedrop"], ["Ofloxacin", "tan_eyedrop"], ["Ointment", "white_eyedrop"], ["Ointment", "gray_eyedrop"], ["Olopatadine", "pink_eyedrop"], ["Omnipred (shake well)", "pink_eyedrop"], ["OptiPranolol", "yellow_eyedrop"], ["Optivar", "white_eyedrop"], ["Oxervate", "white_eyedrop"], ["Pataday", "white_eyedrop"], ["Patanol", "white_eyedrop"], ["Pazeo", "white_eyedrop"], ["Pemirolast", "white_eyedrop"], ["Phenylephrine", "red_eyedrop"], ["Pilocarpine", "turquoise_eyedrop"], ["Polycin ointment", "gray_eyedrop"], ["Polymyxin Trimethoprim", "white_eyedrop"], ["Polytrim", "white_eyedrop"], ["Pred Forte (shake well)", "white_eyedrop"], ["Pred Mild (shake well)", "white_eyedrop"], ["Pred-G", "white_eyedrop"], ["Pred-G ointment", "gray_eyedrop"], ["Prednisolone (shake well)", "pink_eyedrop"], ["Prednisolone (shake well)", "white_eyedrop"], ["Prednisolone/Gatifloxacin/Bromfenac", "tan_eyedrop"], ["Preservative Free Artificial Tears", "white_eyedrop"], ["Prolensa", "gray_eyedrop"], ["Quixin", "tan_eyedrop"], ["Refresh PM ointment", "gray_eyedrop"], ["Refresh Preserv. Free Tears", "white_eyedrop"], ["Refresh Tears", "turquoise_eyedrop"], ["Restasis", "white_eyedrop"], ["Retaine Tears", "white_eyedrop"], ["Rhopressa", "white_eyedrop"], ["Rimexolone (shake well)", "pink_eyedrop"], ["Rocklatan", "white_eyedrop"], ["Simbrinza", "turquoise_eyedrop"], ["Sodium Chloride", "white_eyedrop"], ["Sodium Chloride Ointment", "gray_eyedrop"], ["Soothe Tears", "white_eyedrop"], ["Sulfacetamide", "white_eyedrop"], ["Sulfacetamide/Prednisolone", "white_eyedrop"], ["Systane Balance Tears", "white_eyedrop"], ["Systane Nighttime ointment", "gray_eyedrop"], ["Systane Preserv. Free Tears", "white_eyedrop"], ["Systane Tears", "white_eyedrop"], ["Tafluprost", "turquoise_eyedrop"], ["Tears Naturale", "white_eyedrop"], ["TheraTears", "white_eyedrop"], ["Timolol", "yellow_eyedrop"], ["Timoptic", "yellow_eyedrop"], ["Timoptic-XE", "yellow_eyedrop"], ["Tobradex", "white_eyedrop"], ["Tobradex ST", "white_eyedrop"], ["Tobradex ointment", "gray_eyedrop"], ["Tobramycin", "white_eyedrop"], ["Tobramycin/Dexamethasone", "white_eyedrop"], ["Tobrex", "white_eyedrop"], ["Travatan Z", "turquoise_eyedrop"], ["Travoprost", "turquoise_eyedrop"], ["Trifluridine", "white_eyedrop"], ["Trusopt", "orange_eyedrop"], ["Vancomycin", "white_eyedrop"], ["Vexol (shake wel)", "pink_eyedrop"], ["Vigamox", "tan_eyedrop"], ["Viroptic", "white_eyedrop"], ["Voltaren", "gray_eyedrop"], ["Vyzulta", "turquoise_eyedrop"], ["Xalatan", "turquoise_eyedrop"], ["Xelpros", "turquoise_eyedrop"], ["Xiidra", "white_eyedrop"], ["Zaditor", "white_eyedrop"], ["Zioptan", "turquoise_eyedrop"], ["Zirgan", "white_eyedrop"], ["Zylet", "white_eyedrop"], ["Zymaxid", "tan_eyedrop"]]
    
    var fullDropList = [Eyedrop]()
    
    var favoriteDropList = [Eyedrop]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredDrops: [Eyedrop] = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationController?.setToolbarHidden(true, animated: false)
        
        loadDropList()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Drops"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: animated)
    }

    
    private func loadDropList()
    {
        var index = 0
        for item in FullEyedropListTableViewController.dropList
        {
            guard let drop = Eyedrop(name: item[0], color: UIImage(named:item[1])!, whichEye: 0, dosageTimes: [false], duration: "", favorite: FavoritesData.shared.favorites[index], colorString: item[1])
                    else
                    {
                        fatalError("cannot instantiate eyedrop")
                    }
            fullDropList += [drop]
            
            if FavoritesData.shared.favorites[index]
            {
                favoriteDropList += [drop]
            }
            
            index += 1
        }
//        guard let drop0 = Eyedrop(name: "AK Poly Bac ointment", color: UIImage(named:"gray_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop")
//        }
//        guard let drop1 = Eyedrop(name: "Acetazolamide PLL", color: UIImage(named:"white_eyedrop")!, whichEye: 0, dosageTimes: [false])
//            else
//            {
//                fatalError("cannot instantiate eyedrop 1")
//            }
//        guard let drop2 = Eyedrop(name: "Acular", color: UIImage(named:"gray_eyedrop")!, whichEye: 0, dosageTimes: [false])
//            else
//            {
//                fatalError("cannot instantiate eyedrop 2")
//            }
//        guard let drop2_1 = Eyedrop(name: "Acular LS", color: UIImage(named:"gray_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop")
//        }
//        guard let drop2_2 = Eyedrop(name: "Acuvail", color: UIImage(named:"white_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop")
//        }
//        guard let drop2_3 = Eyedrop(name: "Alamast", color: UIImage(named:"white_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop")
//        }
//        guard let drop2_4 = Eyedrop(name: "Alaway", color: UIImage(named:"white_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop")
//        }
//        guard let drop2_5 = Eyedrop(name: "Alcaftadine", color: UIImage(named:"white_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop")
//        }
//        guard let drop2_6 = Eyedrop(name: "Alocril", color: UIImage(named:"white_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop")
//        }
//        guard let drop2_7 = Eyedrop(name: "Alomide", color: UIImage(named:"white_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop")
//        }
//        guard let drop3 = Eyedrop(name: "Alphagan P", color: UIImage(named:"purple_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop")
//        }
//        guard let drop3_1 = Eyedrop(name: "Alrex (shake well)", color: UIImage(named:"purple_eyedrop")!, whichEye: 0, dosageTimes: [false])
//                   else
//                   {
//                       fatalError("cannot instantiate eyedrop")
//                   }
//        guard let drop3_2 = Eyedrop(name: "Apraclonidine", color: UIImage(named:"purple_eyedrop")!, whichEye: 0, dosageTimes: [false])
//            else
//            {
//                fatalError("cannot instantiate eyedrop")
//            }
//        guard let drop3_3 = Eyedrop(name: "Artificial Tears", color: UIImage(named:"white_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop")
//        }
//        guard let drop4 = Eyedrop(name: "Atropine", color: UIImage(named:"red_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop 4")
//        }
//        guard let drop5 = Eyedrop(name: "Azopt", color: UIImage(named:"yellow_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop 5")
//        }
//        guard let drop6 = Eyedrop(name: "Betaxolol", color: UIImage(named:"blue_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop 6")
//        }
//        guard let drop7 = Eyedrop(name: "Bimatoprost", color: UIImage(named:"turquoise_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop 7")
//        }
//        guard let drop8 = Eyedrop(name: "Brimonidine", color: UIImage(named:"purple_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop 8")
//        }
//        guard let drop9 = Eyedrop(name: "Brinzolamide", color: UIImage(named:"orange_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop 9")
//        }
//        guard let drop10 = Eyedrop(name: "Durezol", color: UIImage(named:"pink_eyedrop")!, whichEye: 0, dosageTimes: [false])
//        else
//        {
//            fatalError("cannot instantiate eyedrop 10")
//        }
//        fullDropList += [drop1, drop2, drop3, drop4, drop5, drop6, drop7, drop8, drop9, drop10]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering
        {
            if section == 0
            {
                return 0
            }
            else
            {
                return filteredDrops.count
            }
        }
        if section == 1
        {
            return fullDropList.count
        }
        else
        {
            return favoriteDropList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyEyedropTableViewCell", for: indexPath) as! MyEyedropTableViewCell
        
        let eyedrop : Eyedrop
        
        
        if isFiltering
        {
            eyedrop = filteredDrops[indexPath.row]
        }
        else if indexPath.section == 1
        {
            eyedrop = fullDropList[indexPath.row]
        }
        else
        {
            eyedrop = favoriteDropList[indexPath.row]
        }
        cell.eyedropName.text = eyedrop.name
        cell.eyedropImage.image = eyedrop.color
        //cell.eyedropInfo.text = ""
        
        if eyedrop.favorite && indexPath.section == 1
        {
            switch traitCollection.userInterfaceStyle {
            case .light: cell.contentView.backgroundColor = UIColor(red: 255/255.0, green: 254/255.0, blue: 212/255.0, alpha: 1.0); break
            case .dark: cell.contentView.backgroundColor = UIColor(red: 66/255.0, green: 104/255.0, blue: 255/255.0, alpha: 1.0); break //UIColor(red: 255/255.0, green: 205/255.0, blue: 66/255.0, alpha: 1.0); break
            default: cell.contentView.backgroundColor = UIColor(red: 255/255.0, green: 254/255.0, blue: 212/255.0, alpha: 1.0)
            }
            
        }
        else
        {
            switch traitCollection.userInterfaceStyle {
            case .light: cell.contentView.backgroundColor = .white; break
            case .dark: cell.contentView.backgroundColor = .black; break
            default: cell.contentView.backgroundColor = .white
            }
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDrop: Eyedrop
        if isFiltering
        {
            selectedDrop = filteredDrops[indexPath.row]
        }
        else if indexPath.section == 1
        {
            selectedDrop = fullDropList[indexPath.row]
        }
        else
        {
            selectedDrop = favoriteDropList[indexPath.row]
        }
        
        if let viewController = storyboard?.instantiateViewController(identifier: "DropViewController") as? DropViewController {
            viewController.eyedrop = selectedDrop
            self.clearsSelectionOnViewWillAppear = true
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView,
          leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
          ->   UISwipeActionsConfiguration? {
            let index:Int?
            if indexPath.section == 0
            {
                //finds corresponding eyedrop in full drops list
                index = self.findEyedropWithName(name: self.favoriteDropList[indexPath.row].name)
            }
            else
            {
                index = indexPath.row
            }
            let favorite:Bool
            if indexPath.section == 1
            {
                if !self.isFiltering
                {
                    favorite = self.fullDropList[indexPath.row].favorite
                }
                else
                {
                    favorite = self.filteredDrops[indexPath.row].favorite
                }
            }
            else
            {
                favorite = true
            }
          let title = favorite ?
            NSLocalizedString("Unfavorite", comment: "Unfavorite") :
            NSLocalizedString("Favorite", comment: "Favorite")

          let action = UIContextualAction(style: .normal, title: title,
            handler: { (action, view, completionHandler) in
            // Update data source when user taps action
                if !self.isFiltering
                {
                self.fullDropList[index!].favorite = !favorite
            completionHandler(true)
                }
                else
                {
                    self.filteredDrops[indexPath.row].favorite = !favorite
                    completionHandler(true)
                }
                //change color of cell
                if let cell = (tableView.cellForRow(at: IndexPath(row: index!, section: 1)))
                {
                    switch self.traitCollection.userInterfaceStyle {
                        case .light: cell.contentView.backgroundColor = favorite ? .white : UIColor(red: 255/255.0, green: 254/255.0, blue: 212/255.0, alpha: 1.0); break
                        case .dark: cell.contentView.backgroundColor = favorite ? .black : UIColor(red: 66/255.0, green: 104/255.0, blue: 255/255.0, alpha: 1.0); break //UIColor(red: 255/255.0, green: 205/255.0, blue: 66/255.0, alpha: 1.0); break
                        default: cell.contentView.backgroundColor = .white
                    }
                }
                
                if !self.isFiltering
                {
                    FavoritesData.shared.favorites[index!] = !favorite
                }
                else
                {
                    FavoritesData.shared.favorites[self.findEyedropWithName(name: self.filteredDrops[indexPath.row].name)] = !favorite
                }
                
                if !self.isFiltering
                {
                    if favorite
                    {
                        let index1 = self.findFavoriteWithName(name: self.fullDropList[index!].name)
                        self.favoriteDropList.remove(at: index1)
                        self.tableView.deleteRows(at: [IndexPath(item: index1, section: 0)], with: .automatic)
                    }
                    else
                    {
                        self.favoriteDropList += [self.fullDropList[indexPath.row]]
                        self.tableView.insertRows(at: [IndexPath(item: self.favoriteDropList.count-1, section: 0)], with: .automatic)
                    }
                }
                else //if filtering then need to update tableview when user is done filtering in order to prevent crash
                {
                    if favorite
                    {
                        let index = self.findFavoriteWithName(name: self.filteredDrops[indexPath.row].name)
                        self.favoriteDropList.remove(at: index)
                        //self.tableView.deleteRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
                    }
                    else
                    {
                        self.favoriteDropList += [self.filteredDrops[indexPath.row]]
                        //self.tableView.insertRows(at: [IndexPath(item: self.favoriteDropList.count-1, section: 0)], with: .automatic)
                    }
                }
                
          })

          action.image = UIImage(named: "Favorite")
          action.backgroundColor = favorite ? .red : .green
          let configuration = UISwipeActionsConfiguration(actions: [action])
          return configuration
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering
        {
            return nil
        }
        if section == 0 && favoriteDropList.count != 0
        {
            return "Favorites"
        }
        else if section == 0
        {
            return nil
        }
        else
        {
            return "All Drops"
        }
    }
    
    func findFavoriteWithName(name: String) -> Int
    {
        var index = 0
        for eyedrop in self.favoriteDropList
        {
            if eyedrop.name == name
            {
                return index
            }
            index += 1
        }
        return -1
    }
    
    func findEyedropWithName(name: String) -> Int
    {
        var index = 0
        for eyedrop in self.fullDropList
        {
            if eyedrop.name == name
            {
                return index
            }
            index += 1
        }
        return -1
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        if searchText == ""
        {
            tableView.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredDrops = fullDropList.filter { (drop: Eyedrop) -> Bool in
        return drop.name.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
    }

}

extension FullEyedropListTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
    self.filterContentForSearchText(searchBar.text!)
  }
}



