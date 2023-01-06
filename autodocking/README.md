# Molecular Docking Base

Autodocking, build upon miniconda3, is a set of tools for helping molecular docking.

## Versions

- conda: 22.11.1
- mamba: 1.1.0
- python: 3.10.8

## Libraries included

| Python Library      | Version |
| ----------- | ----------- |
| openbabel | 3.1.1 |
| mgltools | 1.5.7 |
| rdkit | 2022.09.3 |
| jupyterlab | 3.5.2 |
| vina | 1.2.3 |
| dockstring | 0.2.0 |
| meeko | 0.4.0 |
| biopandas | 0.4.1 |
| biopython | 1.80 |
| pymol-open-source | 2.5.0 |
| py3Dmol | 1.8.1 |
| MDAnalysis | 2.4.1 |
| numpy | 1.24.1 |
| scipy | 1.9.3 |
| prolif | 1.1.0 |
| pdb2pqr | 2.1.1 |
| pdbfixer | 1.8.1 |
| fpocket | 4.0.2 |
| django | 4.1.5 |
| django-ninja | 0.20.0 |

## Binaries

- ledock: LeDock is designed for fast and accurate flexible docking of small molecules into a protein. It achieves a pose-prediction accuracy of greater than 90% on the Astex diversity set and takes about 3 seconds per run for a drug-like molecule.
- lefrag: LeFrag is designed for in silico FBDD, with a pharmacophore oriented fragmentation algorithm. Its functions include automatic fragmentation of a compound library, similarity search, fragment-based core scaffold hopping, pharmacophore filtering, and substructure search.
- lepro: LePro is designed to automatically add hydrogen atoms to proteins and/or nucleic acids by explicitly considering the protonation state of histidine. All crystal water, ions, small ligands and cofactors except HEM were removed.
- lewater: LeWater is designed to detect unfavorable polar interactions, constrained crystal water and hydrogen bonding penalty at the protein-ligand interface.
- prepare_ligand: ADFRsuite 1.0 ligand preparation using python 2.7
- prepare_receptor: ADFRsuite 1.0 receptor preparation using python 2.7
- qvina2.1: Quick Vina 2 is a fast and accurate molecular docking tool, attained at accurately accelerating AutoDock Vina.
- qvina-w: QVina-W a new docking tool particularly useful for wide search space, especially for blind docking. QVina-W utilizes the powerful scoring function of AutoDock Vina, the accelerated search of QVina 2, and adds thorough search for wide search space.
- smina: Smina is fork of AutoDock Vina that is customized to better support scoring function development and high-performance energy minimization. smina is maintained by David Koes at the University of Pittsburgh and is not directly affiliated with the AutoDock project.

## Django project

```shell
python -m django --version

django-admin startproject myproject

python manage.py startapp myapp
```

## Docker use

```docker
FROM firesimulations/autodocking:2023.1.3

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# The deprecation for the aliases np.object, np.bool, np.float, np.complex, np.str,
# and np.int is expired (introduces NumPy 1.20).
# So, numpy is downgraded to 1.21.5
RUN python3 -m pip install --force-reinstall numpy==1.21.5

# Copy project
COPY . .

# Run django server
CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000" ]
```

## Links

- [Github](https://github.com/bio-grids/autodocking-utils)
- [Dockerfile](https://github.com/bio-grids/autodocking-utils/blob/master/autodocking/Dockerfile)
- [Specs File](https://github.com/bio-grids/autodocking-utils/blob/master/autodocking/specs.txt)
- [Specs File (json)](https://github.com/bio-grids/autodocking-utils/blob/master/autodocking/specs.json)
