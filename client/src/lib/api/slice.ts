import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';
import { League, Point } from './types';

export const api = createApi({
  baseQuery: fetchBaseQuery({ baseUrl: process.env.NEXT_PUBLIC_API_BASE_URL }),
  reducerPath: 'api',
  tagTypes: ['Leagues', 'Points'],
  endpoints: (build) => ({
    getLeagues: build.query<League[], void>({
      query: () => 'leagues',
      providesTags: ['Leagues'],
    }),
    createLeague: build.mutation<League, Partial<League>>({
      query: (league) => ({
        url: 'leagues',
        method: 'POST',
        body: league,
      }),
      invalidatesTags: ['Leagues'],
    }),
    getPoints: build.query<Point[], { userLeagueId: number }>({
      query: ({ userLeagueId }) => `points?userLeagueId=${userLeagueId}`,
      providesTags: (result) =>
        result
          ? result.map(({ id }) => ({ type: 'Points' as const, id }))
          : [{ type: 'Points' as const }],
    }),
    // updatePoints: build.mutation<Point[], { userLeagueId: number }>({
    //   query: ({ userLeagueId }) => `points?userLeagueId=${userLeagueId}`,
    //   providesTags: (result) =>
    //     result
    //       ? result.map(({ id }) => ({ type: 'Points' as const, id }))
    //       : [{ type: 'Points' as const }],
    // }),
  }),
});

export const {
  useGetLeaguesQuery,
  useCreateLeagueMutation,
  useGetPointsQuery,
} = api;
