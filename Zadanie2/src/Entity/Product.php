<?php

namespace App\Entity;

use App\Repository\ProductRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ProductRepository::class)]
class Product
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 64)]
    private ?string $Nazwa = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $Opis = null;

    #[ORM\Column]
    private ?float $Cena = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNazwa(): ?string
    {
        return $this->Nazwa;
    }

    public function setNazwa(string $Nazwa): static
    {
        $this->Nazwa = $Nazwa;

        return $this;
    }

    public function getOpis(): ?string
    {
        return $this->Opis;
    }

    public function setOpis(?string $Opis): static
    {
        $this->Opis = $Opis;

        return $this;
    }

    public function getCena(): ?float
    {
        return $this->Cena;
    }

    public function setCena(float $Cena): static
    {
        $this->Cena = $Cena;

        return $this;
    }
}
