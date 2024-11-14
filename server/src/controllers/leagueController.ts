import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const getLeagues = async (
  req: Request,
  res: Response
): Promise<void> => {
  try {
    const leagues = await prisma.league.findMany();
    res.json(leagues);
  } catch (error) {
    res.status(500).json({ message: "Error retrieving leagues." });
  }
};

export const createLeague = async (
  req: Request,
  res: Response
): Promise<void> => {
  const { name, competitionId, description, isPrivate, createdById } = req.body;

  try {
    const newLeague = await prisma.league.create({
      data: {
        name,
        competitionId,
        description,
        isPrivate,
        createdById,
      },
    });

    res.status(201).json(newLeague);
  } catch (error: unknown) {
    if (error instanceof Error) {
      res.status(500).json({ message: error.message });
    } else {
      res.status(500).json({ message: "An unknown error occurred." });
    }
  }
};
