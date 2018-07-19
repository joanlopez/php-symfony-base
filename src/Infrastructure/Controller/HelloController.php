<?php

namespace App\Infrastructure\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/hello")
 */
class HelloController extends AbstractController
{
    /**
     * @Route("", methods="GET", name="hello")
     */
    public function hello()
    {
        return $this->json(['message' => 'Hello World']);
    }
}