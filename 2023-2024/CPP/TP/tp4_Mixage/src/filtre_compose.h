#pragma once
#include <vector>
#include "filtre_base.h"

class filtre_compose : public filtre_base {
	protected:
		std::vector<composant*> mesFiltres;

		unsigned int * bindsEntrees1; // le filtre
		unsigned int * bindsEntrees2; // son entree

		unsigned int* bindsSorties1; // le filtre
		unsigned int* bindsSorties2; // sa sortie


	public:
		filtre_compose(unsigned int nbentree, unsigned int nbsortie) : filtre_base(0,0)
		{
			bindsEntrees1 = new unsigned int[nbentree];
			bindsEntrees2 = new unsigned int[nbentree];

			bindsSorties1 = new unsigned int[nbsortie];
			bindsSorties2 = new unsigned int[nbsortie];
		}

		~filtre_compose() override {
			delete[] bindsEntrees1;
			delete[] bindsEntrees2;

			delete[] bindsSorties1;
			delete[] bindsSorties2;

			while (mesFiltres.size() != 0)
			{
				delete mesFiltres.back();
				mesFiltres.pop_back();
			}
		} 

		unsigned int addComponent(composant* filtreAdd) {
			mesFiltres.push_back(filtreAdd);
			return mesFiltres.size() - 1;
		}

		void bindEntreeComponent(unsigned int entree, unsigned int indexCons, unsigned int entreeCons) const
		{
			bindsEntrees1[entree] = indexCons;
			bindsEntrees2[entree] = entreeCons;
		}

		void bindSortieComponent(unsigned int sortie, unsigned int indexProd, unsigned int sortieProd) const
		{
			bindsSorties1[sortie] = indexProd;
			bindsSorties2[sortie] = sortieProd;
		}

		void connecterEntree(const std::shared_ptr<flot>& f, unsigned int numentree) override {
			consommateur * cons = dynamic_cast<consommateur*>(mesFiltres[bindsEntrees1[numentree]]);

			assert(cons != nullptr);

			cons ->connecterEntree(f, bindsEntrees2[numentree]);
		}

		void linkEntree(unsigned int indexProd, unsigned int indexCons, unsigned int sortieProd, unsigned int entreeCons) {

			producteur* prod = dynamic_cast<producteur*>(mesFiltres[indexProd]);
			consommateur* cons = dynamic_cast<consommateur*>(mesFiltres[indexCons]);

			assert(prod != nullptr);

			cons -> connecterEntree(prod->getSortie(sortieProd), entreeCons);
		}

		const std::shared_ptr<flot>& getSortie(unsigned int numsortie) const override
		{
			producteur* prod = dynamic_cast<producteur*>(mesFiltres[bindsSorties1[numsortie]]);

			assert(prod != nullptr);

			return prod->getSortie(bindsSorties2[numsortie]);
		}

		const std::shared_ptr<flot>& getEntree(unsigned int numentree) const override {
			consommateur* cons = dynamic_cast<consommateur*>(mesFiltres[bindsEntrees1[numentree]]);

			assert(cons != nullptr);

			return cons -> getEntree(bindsEntrees2[numentree]);
		}

		void calculer() override {
			for ( auto i = mesFiltres.begin(); i != mesFiltres.end(); ++i)
			{
				(*i) -> calculer();
			}
		}
};