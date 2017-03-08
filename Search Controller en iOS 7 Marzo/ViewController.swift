//
//  ViewController.swift
//  Search Controller en iOS 7 Marzo
//
//  Created by Alumno on 7/03/17.
//  Copyright © 2017 area51. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController:nil)
    
    var dispositivos = Array<Dispositivo>()

    var dispositivosFiltrador = Array<Dispositivo>()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "Busqueda"
        
        searchController.searchBar.prompt = "Titulo"
        
        searchController.searchBar.barTintColor = UIColor.cyan
        
        searchController.searchResultsUpdater = self
        
        tableView.tableHeaderView = searchController.searchBar
        
        for i in 1...9{
            
            let  dispositivo = Dispositivo()
            
            switch i {
                case 1:
                dispositivo.nombre = "Iphone"
                dispositivo.precio = 599.00
                dispositivo.fabricacion = "2007"
                case 2:
                dispositivo.nombre = "iPod"
                dispositivo.precio = 399.00
                dispositivo.fabricacion = "2001"
                case 3:
                dispositivo.nombre = "iPod Touch"
                dispositivo.precio = 210.00
                dispositivo.fabricacion = "2007"
                case 4:
                dispositivo.nombre = "Ipad"
                dispositivo.precio = 499.00
                dispositivo.fabricacion = "2010"
                case 5:
                dispositivo.nombre = "Ipad Mini"
                dispositivo.precio = 659.00
                dispositivo.fabricacion = "2012"
                case 6:
                dispositivo.nombre = "iMac"
                dispositivo.precio = 1299.00
                dispositivo.fabricacion = "1997"
                case 7:
                dispositivo.nombre = "Mac Pro"
                dispositivo.precio = 2499.00
                dispositivo.fabricacion = "2006"
                case 8:
                dispositivo.nombre = "MacBook Air"
                dispositivo.precio = 1799.00
                dispositivo.fabricacion = "2008"
                default:
                dispositivo.nombre = "MacBook Pro"
                dispositivo.precio = 1499.00
                dispositivo.fabricacion = "2006"
                
            }
            
            dispositivos.append(dispositivo)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
                return dispositivosFiltrador.count
        }
                return dispositivos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        
        let item:Dispositivo
        
        if searchController.isActive && searchController.searchBar.text != "" {
            item = dispositivosFiltrador[indexPath.row]

        }else{
            item = dispositivos[indexPath.row]
        }
        
        cell.textLabel?.text = item.nombre
        cell.detailTextLabel?.text = "$\(item.precio!) | " + item.fabricacion!
        
        return cell
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let texto = searchController.searchBar.text
        
        dispositivosFiltrador = dispositivos.filter({ (dispositivo) -> Bool in
            return
            String(dispositivo.precio).lowercased().contains(texto!.lowercased())
            ||
            dispositivo.nombre.lowercased().contains(texto!.lowercased())
            ||
            dispositivo.fabricacion.lowercased().contains(texto!.lowercased())
        })
        
       /* if(dispositivosFiltrador.count == 0 ){
            dispositivosFiltrador = dispositivos.filter({ (dispositivo) -> Bool in
                return String(dispositivo.nombre).lowercased().contains(texto!.lowercased())
            })
            
            if(dispositivosFiltrador.count == 0 ){
                dispositivosFiltrador = dispositivos.filter({ (dispositivo) -> Bool in
                    return String(dispositivo.fabricacion).lowercased().contains(texto!.lowercased())
                })
            }

        }*/
        
        tableView.reloadData()
    }
    
    


}

