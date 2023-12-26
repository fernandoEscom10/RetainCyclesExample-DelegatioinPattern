//
//  ViewController.swift
//  RetainCyclesExample&DelegatioinPattern
//
//  Created by Fernando Negrete Pimentel on 26/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    let apiClient = APICLient()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Prueba1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Busca un pokemon"
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler:{ [weak self] _ in
            self?.didTapOnAcceptButton()
        }))
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchButton)
        view.addSubview(titleLabel)
        
        apiClient.delegate = self
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.trailingAnchor),
            searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func didTapOnAcceptButton(){
        apiClient.getPokemon()
    }


}

extension ViewController: APICLientDelegate{
    func update(pokemons: PokemonResponseDataModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = pokemons.Pokemons.randomElement()?.name
        }
    }
    
    
}

