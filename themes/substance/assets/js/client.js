import { request, GraphQLClient, gql } from 'graphql-request';
// TODO: Bind all methods to the window object or equivalent export

const endpoint = '/.netlify/functions/comments';

const client = new GraphQLClient(endpoint);

const getCommentsBySlug = slug => client.request(
    gql`query($slug: String!) {
      getCommentsBySlug(slug: $slug) {
        commentId
        isApproved
        slug
        date
        name
        comment
      }
   }`,
   { slug: slug }
);

window.getCommentsBySlug = getCommentsBySlug;

const createComment = (slug, name, comment) => {
    console.log(slug, name, comment);
    return client.request(
    gql`mutation($slug: String!, $name: String!, $comment: String!) {
    createComment(slug: $slug, name: $name, comment: $comment) {
        commentId
        }
    }`,
    { slug, name, comment }
    );
};

window.createComment = createComment;

export const getAllComments = () => client.request(
    gql`query {
        getAllComments {
            commentId
            isApproved
            slug
            date
            name
            comment
        }
    }`
);

window.getAllComments = getAllComments;

export const deleteCommentById = (commentId) => client.request(
    gql`mutation($commentId: String!) {
        deleteCommentById(commentId: $commentId) {
            commentId
        }
    }`,
    { commentId }
);

export const approveCommentById = (commentId) => client.request(
    gql`mutation($commentId: String!) {
        approveCommentById(commentId: $commentId) {
            isApproved
        }
   }`,
   { commentId }
);
