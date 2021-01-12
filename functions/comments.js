require("dotenv").config();
const faunadb = require("faunadb");
const { ApolloServer, gql } = require("apollo-server-lambda");
const q = faunadb.query;

const client = new faunadb.Client({ secret: process.env.HUGO_FAUNA_DB });

const COLLECTION_NAME = process.env.HUGO_FAUNA_COLLECTION;

const typeDefs = gql`
  type Query {
    getAllComments: [CommentObject]
    getCommentsBySlug(slug: String!): [CommentObject]
  }
  type Mutation {
    createComment(slug: String!, name: String!, comment: String): CreatedComment
    approveCommentById(commentId: String!): ApprovedComment
  }
  type ApprovedComment {
    isApproved: Boolean
  }
  type CreatedComment {
    commentId: String
  }
  type CommentObject {
    commentId: String
    isApproved: Boolean
    slug: String
    date: String
    name: String
    comment: String
  }
`;


const resolvers = {
    Query: {
        
	      getAllComments: async () => {
		        const results = await client.query(
		            q.Paginate(q.Match(q.Index("get-all-comments")))
		        );
		        console.log(JSON.stringify(results, null, 2));
		        return results.data.map(([ref, isApproved, slug, date, name, comment]) => ({
		            commentId: ref.id,
			          isApproved,
 			          slug,
			          date,
			          name,
			          comment
		        }));
	      },
	      getCommentsBySlug: async (slug) => {
		        const results = await client.query(
		            q.Paginate(q.Match(q.Index("get-comments-by-slug"), slug))
		        );
		        console.log(JSON.stringify(results, null, 2));
		        return results.data.map(([ref, isApproved, slug, date, name, comment]) => ({
		            commentId: ref.id,
			          isApproved,
 			          slug,
			          date,
			          name,
			          comment
		        }));
	      },
    },
    Mutation: {
        
	      createComment: async (slug, name, comment) => {
            console.log(slug, name, comment);
		        try {
			          const results = await client.query(
				            q.Create(q.Collection(COLLECTION_NAME), {
					              data: {
				  	                isApproved: false,
						                slug,
						                date: new Date().toString(),
						                name,
						                comment
					              }
				            })
			          );
			          console.log('comment created!');
			          console.log(JSON.stringify(results, null, 2));
			          return { commentId: results.ref.id };
		        }
		        catch (e){
		            console.log(e);
                return e;
		        }
	      },
	      approveCommentById: async (commentId) => {
		        const results = await client.query(
			          q.Update(q.Ref(q.Collection(COLLECTION_NAME), commentId), {
				            data: {
				                isApproved: true,
				            },
			          })
		        );
		        console.log(JSON.stringify(results, null, 2));
		        return {
			          isApproved: results.isApproved
		        };
	      },
    }
};

const server = new ApolloServer({
    typeDefs,
    resolvers,
});

exports.handler = server.createHandler({
    cors: {
        origin: "trentfridey.com",
        credentials: true
    }
});
