import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";

const prismaClient = new PrismaClient();

export const getPoints = async (req: Request, res: Response): Promise<void> => {
  const { userLeagueId } = req.query;
  try {
    const points = await prismaClient.point.findMany({
      where: {
        userLeagueId: Number(userLeagueId),
      },
      include: {
        userLeague: {
          include: {
            user: {
              select: {
                username: true,
              },
            },
          },
        },
      },
    });
    res.json(points);
  } catch (error: unknown) {
    if (error instanceof Error) {
      res.status(500).json({ message: error.message });
    } else {
      res.status(500).json({ message: "An unknown error occurred." });
    }
  }
};
