import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const getPredictions = async (
  req: Request,
  res: Response
): Promise<void> => {
  const { leagueId } = req.query;
  try {
    const predictions = await prisma.matchPrediction.findMany();
    res.json(predictions);
  } catch (error) {
    res.status(500).json({ message: "Error retrieving leagues." });
  }
};
