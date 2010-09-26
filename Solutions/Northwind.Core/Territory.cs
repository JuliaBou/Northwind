﻿namespace Northwind.Core
{
    using System.Collections.Generic;

    using NHibernate.Validator.Constraints;

    using Northwind.Core.Organization;

    using SharpArch.Core;
    using SharpArch.Core.DomainModel;

    public class Territory : EntityWithTypedId<string>, IHasAssignedId<string>
    {
        private const int IdMaxLength = 20;

        public Territory()
        {
            this.InitMembers();
        }

        /// <summary>
        ///   Creates valid domain object
        /// </summary>
        public Territory(string description, Region regionBelongingTo)
            : this()
        {
            this.RegionBelongingTo = regionBelongingTo;
            this.Description = description;
        }

        [DomainSignature]
        [NotNullNotEmpty]
        public virtual string Description { get; set; }

        /// <summary>
        ///   Note the protected set...only the ORM should set the collection reference directly
        ///   after it's been initialized in <see cref = "InitMembers" />
        /// </summary>
        public virtual IList<Employee> Employees { get; protected set; }

        [DomainSignature]
        [NotNull]
        public virtual Region RegionBelongingTo { get; set; }

        /// <summary>
        ///   Let me remind you that I completely disdane assigned Ids...another lesson to be learned
        ///   from the fallacies of the Northwind DB.
        /// </summary>
        public virtual void SetAssignedIdTo(string assignedId)
        {
            Check.Require(!string.IsNullOrEmpty(assignedId) && assignedId.Length <= IdMaxLength);
            this.Id = assignedId;
        }

        private void InitMembers()
        {
            // Init the collection so it's never null
            this.Employees = new List<Employee>();
        }
    }
}